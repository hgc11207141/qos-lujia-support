package com.paladin.qos.core;

import com.paladin.framework.spring.SpringBeanHelper;
import com.paladin.framework.spring.SpringContainer;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.scheduling.annotation.Scheduled;
import org.springframework.stereotype.Component;

import java.util.ArrayList;
import java.util.List;
import java.util.Map;
import java.util.concurrent.*;

@Component
public class DataTaskManager implements SpringContainer {

    @Value("${qos.data-task-pool-size}")
    private int dataTaskPoolSize = 50;

    @Value("${qos.simple-mode}")
    private boolean simpleMode = false;

    private ExecutorService executorService;

    private volatile List<DataTask> scheduleTasks;
    private Map<String, DataTask> scheduleTaskMap = new ConcurrentHashMap<>();

    private volatile List<DataTask> realTimeTasks;
    private Map<String, DataTask> realTimeTaskMap = new ConcurrentHashMap<>();


    public boolean initialize() {
        Map<String, DataTask> taskMap = SpringBeanHelper.getBeansByType(DataTask.class);
        if (taskMap != null) {
            for (Map.Entry<String, DataTask> entry : taskMap.entrySet()) {
                realTimeTaskMap.put(entry.getKey(), entry.getValue());
            }
            scheduleTasks = new ArrayList<>(scheduleTaskMap.values());
        }

        executorService = new ThreadPoolExecutor(dataTaskPoolSize, dataTaskPoolSize, 0, TimeUnit.SECONDS, new ArrayBlockingQueue<>(512), // 使用有界队列，避免OOM
                new ThreadPoolExecutor.DiscardPolicy());

        return true;
    }

    ;

    public void registerTaskSchedule(List<DataTask> tasks) {
        for (DataTask task : tasks) {
            scheduleTaskMap.put(task.getId(), task);
        }
        scheduleTasks = new ArrayList<>(scheduleTaskMap.values());
    }

    public void registerTaskRealTime(List<DataTask> tasks) {
        for (DataTask task : tasks) {
            realTimeTaskMap.put(task.getId(), task);
        }
        realTimeTasks = new ArrayList<>(realTimeTaskMap.values());
    }

    /**
     * 每小时执行
     */
    @Scheduled(cron = "0 0 0/1 * * ?")
    public void executeScheduleNight() {
        if (simpleMode || executorService == null) {
            return;
        }

        for (DataTask task : scheduleTasks) {
            if (task.isEnabled() && !task.isRun() && task.needScheduleNow()) {
                long threadEndTime = System.currentTimeMillis() + task.getExecuteHours() * 60 * 60 * 1000;
                task.setThreadEndTime(threadEndTime);
                executorService.execute(task);
            }
        }
    }

    /**
     * 每分钟尝试去执行
     */
    @Scheduled(cron = "0 */1 * * * ?")
    public void executeRealTime() {
        if (simpleMode || executorService == null) {
            return;
        }

        for (DataTask task : realTimeTasks) {
            boolean execute = task.isEnabled() && !task.isRun() && task.isRealTime() && task.doRealTime();
            if (execute) {
                executorService.execute(task);
            }
        }
    }

    /**
     * 执行任务
     *
     * @param taskId
     * @param threadEndTime
     * @return
     */
    public boolean executeTask(String taskId, long threadEndTime) {
        if (executorService != null) {
            DataTask task = getTask(taskId);
            if (task != null && task.isEnabled() && !task.isRun()) {
                task.setThreadEndTime(threadEndTime);
                executorService.execute(task);
                return true;
            }
        }
        return false;
    }

    public List<DataTask> findScheduleTasks(int level, Object label) {
        return findTasks(scheduleTasks, level, label);
    }

    public List<DataTask> findRealTimeTasks(int level, Object label) {
        return findTasks(realTimeTasks, level, label);
    }

    private List<DataTask> findTasks(List<DataTask> dataTasks, Integer level, Object label) {
        List<DataTask> tasks = new ArrayList<>(dataTasks.size());
        for (DataTask task : dataTasks) {
            if (level != null) {
                if (level != task.getLevel()) {
                    continue;
                }
            }
            if (label != null) {
                List<Object> labels = task.getLabels();
                boolean has = false;

                if (labels != null) {
                    for (Object lab : labels) {
                        if (label.equals(lab)) {
                            has = true;
                            break;
                        }
                    }
                }

                if (!has) {
                    continue;
                }
            }
            tasks.add(task);
        }
        return tasks;
    }

    public DataTask getTask(String id) {

        for (DataTask task : scheduleTasks) {
            if (task.getId().equals(id)) {
                return task;
            }
        }

        for (DataTask task : realTimeTasks) {
            if (task.getId().equals(id)) {
                return task;
            }
        }

        return null;
    }

}

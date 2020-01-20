package com.paladin.qos.controller.task;

import java.util.ArrayList;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.paladin.framework.web.response.CommonResponse;
import com.paladin.qos.core.DataTask;
import com.paladin.qos.core.DataTaskManager;

@Controller
@RequestMapping("/qos/data/task")
public class DataTaskController {
	@Autowired
	private DataTaskManager taskManager;

	@GetMapping("/index")
	public String index() {
		return "/qos/task/index";
	}

	@GetMapping("/list")
	@ResponseBody
	public Object getRealTimeTaskStatus(@RequestParam(required = false) String type, @RequestParam(required = false) Integer level,
			@RequestParam(required = false) String label) {
		List<DataTaskVO> result = null;
		if ("schedule".equals(type)) {
			result = convertVO(taskManager.findScheduleTasks(level, label));
		} else if ("realtime".equals(type)) {
			result = convertVO(taskManager.findRealTimeTasks(level, label));
		} else {
			result = new ArrayList<>();
			result.addAll(convertVO(taskManager.findScheduleTasks(level, label)));
			result.addAll(convertVO(taskManager.findRealTimeTasks(level, label)));
		}

		return CommonResponse.getSuccessResponse(result);
	}

	@GetMapping("/execute")
	@ResponseBody
	public Object executeTask(String id, int hour) {
		long endTime = System.currentTimeMillis() + hour * 60 * 60 * 1000;
		return CommonResponse.getSuccessResponse(taskManager.executeTask(id, endTime));
	}

	private List<DataTaskVO> convertVO(List<DataTask> tasks) {
		if (tasks != null) {
			List<DataTaskVO> vos = new ArrayList<>(tasks.size());
			for (DataTask task : tasks) {
				vos.add(new DataTaskVO(task));
			}
			return vos;
		}
		return null;
	}
}

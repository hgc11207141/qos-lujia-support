package com.paladin.common.service.syst;

import java.io.ByteArrayInputStream;
import java.io.ByteArrayOutputStream;
import java.io.IOException;
import java.io.InputStream;
import java.io.OutputStream;
import java.nio.file.FileAlreadyExistsException;
import java.nio.file.Files;
import java.nio.file.Path;
import java.nio.file.Paths;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Arrays;
import java.util.Date;
import java.util.List;

import javax.annotation.PostConstruct;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.web.multipart.MultipartFile;

import com.github.pagehelper.Page;
import com.github.pagehelper.PageHelper;
import com.paladin.common.mapper.syst.SysAttachmentMapper;
import com.paladin.common.model.syst.SysAttachment;
import com.paladin.common.service.syst.dto.PictureSaveConfig;
import com.paladin.framework.common.Condition;
import com.paladin.framework.common.OffsetPage;
import com.paladin.framework.common.PageResult;
import com.paladin.framework.common.QueryType;
import com.paladin.framework.core.ServiceSupport;
import com.paladin.framework.core.configuration.web.WebProperties;
import com.paladin.framework.core.exception.BusinessException;
import com.paladin.framework.core.exception.SystemException;
import com.paladin.framework.utils.Base64Util;
import com.paladin.framework.utils.uuid.UUIDUtil;

import net.coobird.thumbnailator.Thumbnails;
import net.coobird.thumbnailator.Thumbnails.Builder;

@Service
public class SysAttachmentService extends ServiceSupport<SysAttachment> {

	@Autowired
	private SysAttachmentMapper sysAttachmentMapper;

	@Autowired
	private WebProperties webProperties;

	private long maxFileByteSize;

	private int maxFileNameSize = 50;

	private String attachmentPath;

	private int maxFileSize;

	@PostConstruct
	protected void initialize() {
		attachmentPath = webProperties.getFilePath();
		if (attachmentPath.startsWith("file:")) {
			attachmentPath = attachmentPath.substring(5);
		}

		attachmentPath = attachmentPath.replaceAll("\\\\", "/");

		if (!attachmentPath.endsWith("/")) {
			attachmentPath += "/";
		}

		maxFileSize = webProperties.getFileMaxSize();
		if (maxFileSize <= 0) {
			maxFileSize = 10;
		}

		maxFileByteSize = maxFileSize * 1024 * 1024;

		// ????????????
		Path root = Paths.get(attachmentPath);
		try {
			Files.createDirectories(root);
		} catch (IOException e) {
			throw new RuntimeException("??????????????????????????????", e);
		}
	}

	/**
	 * ???????????????MultipartFile?????????
	 * 
	 * @param file
	 * @param attachmentName
	 * @return
	 */
	public SysAttachment createAttachment(MultipartFile file, String attachmentName) {
		return createAttachment(file, attachmentName, null);
	}

	/**
	 * ???????????????MultipartFile?????????
	 * 
	 * @param file
	 * @param attachmentName
	 * @param userType
	 * @return
	 */
	public SysAttachment createAttachment(MultipartFile file, String attachmentName, Integer userType) {
		String id = UUIDUtil.createUUID();
		String name = file.getOriginalFilename();
		long size = file.getSize();
		if (size > maxFileByteSize) {
			throw new BusinessException("????????????????????????" + maxFileSize + "MB");
		}

		SysAttachment attachment = new SysAttachment();
		attachment.setId(id);
		attachment.setSize(size);
		attachment.setType(file.getContentType());

		if (name != null && name.length() > 0) {
			int i = name.lastIndexOf(".");
			if (i >= 0) {
				String suffix = name.substring(i);
				attachment.setSuffix(suffix);
			}

			if (attachmentName == null || attachmentName.length() == 0) {
				attachmentName = i >= 0 ? name.substring(0, i) : name;
			}
		}

		attachment.setName(attachmentName);

		if (userType == null || (userType != SysAttachment.USE_TYPE_COLUMN_RELATION && userType != SysAttachment.USE_TYPE_RESOURCE)) {
			userType = SysAttachment.USE_TYPE_COLUMN_RELATION;
		}

		attachment.setUseType(userType);

		try {
			saveFile(file.getBytes(), attachment);
		} catch (IOException e) {
			throw new SystemException("????????????????????????", e);
		}

		save(attachment);
		return attachment;
	}

	/**
	 * ???????????????base64?????????
	 * 
	 * @param base64String
	 * @param filename
	 * @return
	 */
	public SysAttachment createAttachment(String base64String, String filename, String type) {
		return createAttachment(base64String, filename, null);
	}

	/**
	 * ???????????????base64?????????
	 * 
	 * @param base64String
	 * @param filename
	 * @param userType
	 * @return
	 */
	public SysAttachment createAttachment(String base64String, String filename, String type, Integer userType) {
		String id = UUIDUtil.createUUID();
		long size = Base64Util.getFileSize(base64String);
		if (size > maxFileByteSize) {
			throw new BusinessException("????????????????????????" + maxFileSize + "MB");
		}

		SysAttachment attachment = new SysAttachment();
		attachment.setId(id);
		attachment.setSize(size);
		attachment.setType(type);

		if (filename != null && filename.length() > 0) {
			int i = filename.lastIndexOf(".");
			if (i >= 0) {
				String suffix = filename.substring(i);
				attachment.setSuffix(suffix);
				attachment.setName(filename.substring(0, i));
			} else {
				attachment.setName(filename);
			}
		} else {
			throw new BusinessException("?????????????????????");
		}

		if (userType == null || (userType != SysAttachment.USE_TYPE_COLUMN_RELATION && userType != SysAttachment.USE_TYPE_RESOURCE)) {
			userType = SysAttachment.USE_TYPE_COLUMN_RELATION;
		}

		attachment.setUseType(userType);

		try {
			saveFile(Base64Util.decode(base64String), attachment);
		} catch (IOException e) {
			throw new SystemException("????????????????????????", e);
		}
		save(attachment);
		return attachment;
	}

	/**
	 * ??????????????????????????????
	 * 
	 * @param data
	 * @param filename
	 * @param type
	 * @return
	 */
	public SysAttachment createAttachment(byte[] data, String filename, String type) {
		return createAttachment(data, filename, type, null, null);
	}

	/**
	 * ??????????????????????????????
	 * 
	 * @param base64String
	 * @param filename
	 * @param subFilePath
	 *            ?????????
	 * @return
	 */
	public SysAttachment createAttachment(byte[] data, String filename, String type, String subFilePath, Integer userType) {
		String id = UUIDUtil.createUUID();
		long size = data.length;
		if (size > maxFileByteSize) {
			throw new BusinessException("????????????????????????" + maxFileSize + "MB");
		}

		SysAttachment attachment = new SysAttachment();
		attachment.setId(id);
		attachment.setSize(size);
		attachment.setType(type);

		if (filename != null && filename.length() > 0) {
			int i = filename.lastIndexOf(".");
			if (i >= 0) {
				String suffix = filename.substring(i);
				attachment.setSuffix(suffix);
				attachment.setName(filename.substring(0, i));
			} else {
				attachment.setName(filename);
			}
		} else {
			throw new BusinessException("?????????????????????");
		}

		if (userType == null || (userType != SysAttachment.USE_TYPE_COLUMN_RELATION && userType != SysAttachment.USE_TYPE_RESOURCE)) {
			userType = SysAttachment.USE_TYPE_COLUMN_RELATION;
		}
		attachment.setUseType(userType);

		try {
			saveFile(data, attachment, subFilePath);
		} catch (IOException e) {
			throw new SystemException("????????????????????????", e);
		}
		save(attachment);
		return attachment;
	}

	private static double baseSize = 1 * 1024 * 1024;

	/**
	 * ??????????????????????????????????????????????????????????????????????????????????????????????????????????????????????????????
	 * 
	 * @param file
	 * @param pictureName
	 * @param userType
	 * @return
	 */
	public SysAttachment createPictureAndCompress(MultipartFile file, String pictureName, Integer userType) {
		return createPictureAndCompress(file, pictureName, userType, null, null);
	}

	/**
	 * ??????????????????????????????????????????????????????????????????????????????????????????????????????????????????????????????
	 * 
	 * @param file
	 * @param pictureName
	 * @param userType
	 * @param thumbnailWidth
	 *            ?????????????????????????????????????????????null
	 * @param thumbnailHeight
	 *            ?????????????????????????????????????????????null
	 * @return
	 */
	public SysAttachment createPictureAndCompress(MultipartFile file, String pictureName, Integer userType, Integer thumbnailWidth, Integer thumbnailHeight) {

		PictureSaveConfig config = null;

		long size = file.getSize();
		if (size > baseSize) {
			double scale = baseSize / size;
			scale = Math.sqrt(scale) * 0.8;
			config = new PictureSaveConfig();
			config.setScale(scale);
		}

		if (thumbnailHeight != null && thumbnailWidth != null) {
			if (config == null) {
				config = new PictureSaveConfig();
			}

			config.setThumbnailHeight(thumbnailHeight);
			config.setThumbnailWidth(thumbnailWidth);
		}

		return createPicture(file, pictureName, null, config);
	}

	/**
	 * ??????????????????????????????????????????????????????????????????????????????????????????????????????????????????????????????
	 * 
	 * @param base64str
	 * @param pictureName
	 * @param type
	 * @param userType
	 * @return
	 */
	public SysAttachment createPictureAndCompress(String base64str, String pictureName, String type, Integer userType) {
		return createPictureAndCompress(base64str, pictureName, type, userType, null, null);
	}

	/**
	 * ??????????????????????????????????????????????????????????????????????????????????????????????????????????????????????????????
	 * 
	 * @param base64str
	 * @param pictureName
	 * @param type
	 * @param userType
	 * @param thumbnailWidth
	 *            ?????????????????????????????????????????????null
	 * @param thumbnailHeight
	 *            ?????????????????????????????????????????????null
	 * @return
	 */
	public SysAttachment createPictureAndCompress(String base64str, String pictureName, String type, Integer userType, Integer thumbnailWidth,
			Integer thumbnailHeight) {

		PictureSaveConfig config = null;

		long size = Base64Util.getFileSize(base64str);
		if (size > baseSize) {
			double scale = baseSize / size;
			scale = Math.sqrt(scale) * 0.8;
			config = new PictureSaveConfig();
			config.setScale(scale);
		}

		if (thumbnailHeight != null && thumbnailWidth != null) {
			if (config == null) {
				config = new PictureSaveConfig();
			}

			config.setThumbnailHeight(thumbnailHeight);
			config.setThumbnailWidth(thumbnailWidth);
		}

		return createPicture(base64str, pictureName, type, null, config);
	}

	/**
	 * ????????????
	 * 
	 * @param file
	 * @param pictureName
	 * @param userType
	 * @param config
	 *            ?????????????????????null????????????
	 * @return
	 */
	public SysAttachment createPicture(MultipartFile file, String pictureName, Integer userType, PictureSaveConfig config) {
		String id = UUIDUtil.createUUID();
		String name = file.getOriginalFilename();
		long size = file.getSize();
		if (size > maxFileByteSize) {
			throw new BusinessException("????????????????????????" + maxFileSize + "MB");
		}

		SysAttachment attachment = new SysAttachment();
		attachment.setId(id);
		attachment.setSize(size);
		attachment.setType(file.getContentType());

		if (name != null && name.length() > 0) {
			int i = name.lastIndexOf(".");
			if (i >= 0) {
				String suffix = name.substring(i);
				attachment.setSuffix(suffix);
			}

			if (pictureName == null || pictureName.length() == 0) {
				pictureName = i >= 0 ? name.substring(0, i) : name;
			}
		}

		attachment.setName(pictureName);

		if (userType == null || (userType != SysAttachment.USE_TYPE_COLUMN_RELATION && userType != SysAttachment.USE_TYPE_RESOURCE)) {
			userType = SysAttachment.USE_TYPE_COLUMN_RELATION;
		}

		attachment.setUseType(userType);

		try {
			savePicture(file.getInputStream(), attachment, null, config);
		} catch (IOException e) {
			throw new SystemException("????????????????????????", e);
		}

		save(attachment);
		return attachment;
	}

	/**
	 * ???????????????base64???
	 * 
	 * @param base64str
	 * @param pictureName
	 * @param type
	 * @param userType
	 * @param config
	 *            ?????????????????????null????????????
	 * @return
	 */
	public SysAttachment createPicture(String base64str, String pictureName, String type, Integer userType, PictureSaveConfig config) {
		String id = UUIDUtil.createUUID();
		long size = Base64Util.getFileSize(base64str);
		if (size > maxFileByteSize) {
			throw new BusinessException("????????????????????????" + maxFileSize + "MB");
		}

		SysAttachment attachment = new SysAttachment();
		attachment.setId(id);
		attachment.setSize(size);

		if (type == null || type.length() == 0) {
			type = "image/jpeg";
		}
		attachment.setType(type);

		if (pictureName != null && pictureName.length() > 0) {
			int i = pictureName.lastIndexOf(".");
			if (i >= 0) {
				String suffix = pictureName.substring(i);
				attachment.setSuffix(suffix);
				attachment.setName(pictureName.substring(0, i));
			} else {
				attachment.setName(pictureName);
			}
		} else {
			throw new BusinessException("?????????????????????");
		}

		attachment.setName(pictureName);

		if (userType == null || (userType != SysAttachment.USE_TYPE_COLUMN_RELATION && userType != SysAttachment.USE_TYPE_RESOURCE)) {
			userType = SysAttachment.USE_TYPE_COLUMN_RELATION;
		}

		attachment.setUseType(userType);

		try {
			byte[] data = Base64Util.decode(base64str);
			savePicture(new ByteArrayInputStream(data), attachment, null, config);
		} catch (IOException e) {
			throw new SystemException("????????????????????????", e);
		}

		save(attachment);
		return attachment;
	}

	/**
	 * ????????????????????????????????????
	 * 
	 * @param input
	 * @param attachment
	 * @param subPath
	 * @param config
	 * @return
	 * @throws IOException
	 */
	private SysAttachment savePicture(InputStream input, SysAttachment attachment, String subPath, PictureSaveConfig config) throws IOException {

		Integer width = config == null ? null : config.getWidth();
		Integer height = config == null ? null : config.getHeight();
		Double scale = config == null ? null : config.getScale();
		Double quality = config == null ? null : config.getQuality();
		Integer thumbnailWidth = config == null ? null : config.getThumbnailWidth();
		Integer thumbnailHeight = config == null ? null : config.getThumbnailHeight();

		String filename = attachment.getId();
		String suffix = attachment.getSuffix();
		if (suffix != null) {
			filename += suffix;
		}

		if (subPath == null || subPath.length() == 0) {
			subPath = format.format(new Date());
		}

		Path path = Paths.get(attachmentPath, subPath);
		if (!Files.exists(path)) {
			try {
				Files.createDirectory(path);
			} catch (FileAlreadyExistsException e1) {
				// ??????
			}
		}

		String pelativePath = subPath + "/" + filename;
		attachment.setPelativePath(pelativePath);
		attachment.setCreateTime(new Date());

		if (thumbnailWidth != null && thumbnailHeight != null) {
			ByteArrayOutputStream output = new ByteArrayOutputStream();
			byte[] buffer = new byte[2048];
			int len;
			while ((len = input.read(buffer)) > -1) {
				output.write(buffer, 0, len);
			}

			// ???????????????
			input = new ByteArrayInputStream(output.toByteArray());

			String thumbnailPelativePath = subPath + "/t_" + filename;
			try (OutputStream out = Files.newOutputStream(Paths.get(attachmentPath + thumbnailPelativePath))) {
				Thumbnails.of(input).size(thumbnailWidth, thumbnailHeight).toOutputStream(out);
			}

			attachment.setThumbnailPelativePath(thumbnailPelativePath);
			input.reset();
		}

		if ((width != null && height != null) || scale != null || quality != null) {
			// ??????????????????????????????????????????
			boolean changed = false;
			Builder<? extends InputStream> builder = Thumbnails.of(input);
			if (width != null && height != null) {
				builder.size(width, height);
				changed = true;
			}

			if (scale != null) {
				builder.scale(scale, scale);
				changed = true;
			}

			if (quality != null) {
				if (!changed) {
					// ??????????????????size???????????????????????????????????????????????????
					builder.scale(1f);
				}
				builder.outputQuality(quality);
			}

			try (OutputStream out = Files.newOutputStream(Paths.get(attachmentPath + pelativePath))) {
				builder.toOutputStream(out);
			}
		} else {
			// ?????????????????????
			try (OutputStream out = Files.newOutputStream(Paths.get(attachmentPath + pelativePath))) {
				byte[] buffer = new byte[2048];
				int len;
				while ((len = input.read(buffer)) > -1) {
					out.write(buffer, 0, len);
				}
			}
		}

		// ???????????????????????????
		String attachmentName = attachment.getName();
		if (attachmentName != null && attachmentName.length() > maxFileNameSize) {
			attachmentName = attachmentName.substring(0, maxFileNameSize);
		}

		return attachment;
	}

	/**
	 * ?????????????????????????????????????????????????????????????????????????????????
	 * 
	 * @param data
	 * @param attachment
	 * @throws IOException
	 */
	private void saveFile(byte[] data, SysAttachment attachment) throws IOException {
		saveFile(data, attachment, null);
	}

	/*
	 * TODO ???????????????????????????????????????????????????????????????????????????????????????????????????????????????????????????
	 * 
	 */
	@SuppressWarnings("unused")
	private Path currentPath = null;
	private SimpleDateFormat format = new SimpleDateFormat("yyyyMMdd");

	/**
	 * ??????????????????????????????????????????????????????
	 * 
	 * @param data
	 * @param attachment
	 * @param subPath
	 * @throws IOException
	 */
	private void saveFile(byte[] data, SysAttachment attachment, String subPath) throws IOException {
		if (data == null || data.length == 0) {
			throw new SystemException("????????????");
		}

		String filename = attachment.getId();
		String suffix = attachment.getSuffix();
		if (suffix != null) {
			filename += suffix;
		}

		if (subPath == null || subPath.length() == 0) {
			subPath = format.format(new Date());
		}

		Path path = Paths.get(attachmentPath, subPath);
		if (!Files.exists(path)) {
			try {
				Files.createDirectory(path);
			} catch (FileAlreadyExistsException e1) {
				// ??????
			}
		}

		String pelativePath = subPath + "/" + filename;
		Files.write(Paths.get(attachmentPath + pelativePath), data);

		attachment.setPelativePath(pelativePath);
		attachment.setCreateTime(new Date());

		// ???????????????????????????
		String attachmentName = attachment.getName();
		if (attachmentName != null && attachmentName.length() > maxFileNameSize) {
			attachmentName = attachmentName.substring(0, maxFileNameSize);
		}
	}

	/**
	 * ????????????????????????
	 * 
	 * @param ids
	 * @return
	 */
	public List<SysAttachment> getAttachment(String... ids) {
		return searchAll(new Condition(SysAttachment.COLUMN_FIELD_ID, QueryType.IN, Arrays.asList(ids)));
	}

	/**
	 * ????????????????????????
	 * 
	 * @param ids
	 * @return
	 */
	public PageResult<SysAttachment> getResourceImagePage(OffsetPage query) {
		Page<SysAttachment> page = PageHelper.offsetPage(query.getOffset(), query.getLimit());
		sysAttachmentMapper.findImageResource();
		return new PageResult<>(page);
	}

	/**
	 * ?????????????????????????????????????????????????????????
	 * 
	 * @param idString
	 * @param attachmentFiles
	 * @return
	 */
	public List<SysAttachment> checkOrCreateAttachment(String idString, MultipartFile... attachmentFiles) {

		List<SysAttachment> attIds = null;

		if (idString != null && idString.length() != 0) {
			attIds = getAttachment(idString.split(","));

		}

		if (attachmentFiles != null) {
			if (attIds == null) {
				attIds = new ArrayList<>(attachmentFiles.length);
			}
			for (MultipartFile file : attachmentFiles) {
				if(file != null) {
					SysAttachment a = createAttachment(file, null);
					attIds.add(a);
				}
			}
		}

		return attIds;
	}

	/**
	 * ????????????ID?????????
	 * 
	 * @param attachments
	 * @return
	 */
	public String splicingAttachmentId(List<SysAttachment> attachments) {
		if (attachments != null && attachments.size() > 0) {
			String str = "";
			for (SysAttachment attachment : attachments) {
				str += attachment.getId() + ",";
			}
			return str.substring(0, str.length() - 1);
		}
		return null;
	}

}
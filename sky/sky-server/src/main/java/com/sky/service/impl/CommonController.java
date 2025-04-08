package com.sky.service.impl;

import com.sky.constant.MessageConstant;
import com.sky.result.Result;
import com.sky.service.DishService;
import com.sky.utils.AliOssUtil;
import lombok.extern.slf4j.Slf4j;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;
import org.springframework.web.multipart.MultipartFile;

import java.io.IOException;
import java.util.UUID;

/**
 * 通用接口
 */
@RestController
@Slf4j
@RequestMapping("/admin/common")
public class CommonController {
    @Autowired
    private AliOssUtil aliOssUtil;
    /**
     * 文件上传
     * @param file
     * @return
     */

    @PostMapping("/upload")
    public Result<String> upload(MultipartFile file) {
        log.info("文件上传：{}", file);
        String originalFilename = file.getOriginalFilename();
        String extension = originalFilename.substring(originalFilename.lastIndexOf("."));
        String fileName = UUID.randomUUID().toString() + extension;
        // 上传到阿里云OSS
        String url = null;

        try {
            url = aliOssUtil.upload(file.getBytes(),fileName);
            log.info("文件上传成功，{}", url);
            return Result.success(url);
        } catch (IOException e) {
            log.error("文件上传失败", e);
        }
        return Result.error(MessageConstant.UPLOAD_FAILED);
    }
}

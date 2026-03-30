package com.sp.app.service.serviceImpl;

import com.sp.app.common.FileManager;
import com.sp.app.domain.Item;
import com.sp.app.mapper.ItemMapper;
import com.sp.app.service.ItemService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.web.multipart.MultipartFile;

import java.util.ArrayList;
import java.util.List;
import java.util.Map;

@Service
public class itemServiceImpl implements ItemService {
    @Autowired
    private ItemMapper mapper;

    @Autowired
    private FileManager fileManager;

    @Override
    public void insertShop(Item dto, List<MultipartFile> subImages, String pathname) throws Exception {
        try {

            if (dto.getSelectFile() == null || dto.getSelectFile().isEmpty()) {
                throw new Exception("사진을 등록해주세요.");
            }
            if (dto.getItemName() == null || dto.getItemName().trim().isEmpty()) {
                throw new Exception("상품명을 입력해주세요.");
            }

            // 대표 사진 업로드
            String saveFileName = fileManager.doFileUpload(dto.getSelectFile(), pathname);
            if (saveFileName == null) throw new Exception("파일 업로드 실패.");

            dto.setSaveFileName(saveFileName);
            dto.setOriginalFileName(dto.getSelectFile().getOriginalFilename());
            dto.setFilePath(pathname);

            // 추가 사진 업로드
            if (subImages != null && !subImages.isEmpty()) {
                List<String> subNames = new ArrayList<>();
                for (MultipartFile sub : subImages) {
                    if (sub != null && !sub.isEmpty()) {
                        String subSaved = fileManager.doFileUpload(sub, pathname);
                        if (subSaved != null) subNames.add(subSaved);
                    }
                }
                if (!subNames.isEmpty()) {
                    dto.setSubFileNames(String.join(",", subNames));
                }
            }

            mapper.insertShop(dto);

        } catch (Exception e) {
            System.out.println("상품 등록 오류: " + e.getMessage());
            e.printStackTrace();
            throw e;
        }
    }

    @Override
    public List<Item> shopList(Map<String, Object> map) {
        List<Item> list = null;
        try {
            list = mapper.shopList(map);
        } catch (Exception e) {
            e.printStackTrace();
            throw e;
        }
        return list;
    }
}

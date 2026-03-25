package com.sp.app.service.serviceImpl;

import com.sp.app.common.FileManager;
import com.sp.app.domain.Item;
import com.sp.app.mapper.ItemMapper;
import com.sp.app.service.ItemService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

@Service
public class itemServiceImpl implements ItemService {
    @Autowired
    private ItemMapper mapper;

    @Autowired
    private FileManager fileManager;

    @Override
    public void insertShop(Item dto, String pathname) throws Exception {
        try {

            // 파일 자체가 null 체크
            if (dto.getSelectFile() == null || dto.getSelectFile().isEmpty()) {
                throw new Exception("사진을 등록해주세요.");
            }

            // 상품명 null 체크
            if (dto.getItemName() == null || dto.getItemName().trim().isEmpty()) {
                throw new Exception("상품명을 입력해주세요.");
            }

            // 파일 업로드
            String saveFileName = fileManager.doFileUpload(dto.getSelectFile(), pathname);
            if (saveFileName != null)  {
                dto.setSaveFileName(saveFileName);
                dto.setOriginalFileName(dto.getSelectFile().getOriginalFilename());
                dto.setFilePath(pathname);

                // SHOP_ITEM만 insert (PHOTO_FILE 건드리지 않음)
                mapper.insertShop(dto);
        } else {
            throw new Exception("파일 업로드 실패. 파일 이름이 null입니다.");
        }

        } catch (Exception e) {
            System.out.println("상품 등록 오류: " + e.getMessage());
        }

    }
}

package com.book.service;

import com.book.mapper.AdminMapper;
import com.book.mapper.ReaderCardMapper;
import com.book.mapper.ReaderInfoMapper;
import com.book.domain.ReaderCard;
import com.book.domain.ReaderInfo;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;


//这包含了验证用户身份的业务逻辑，调用DAO层来检查用户凭证。
@Service
public class LoginService {
    @Autowired
    private ReaderCardMapper readerCardMapper;
    @Autowired
    private ReaderInfoMapper readerInfoMapper;
    @Autowired
    private AdminMapper adminMapper;
    //    @Autowired
    public void setReaderCardDao(ReaderCardMapper readerCardMapper) {
        this.readerCardMapper = readerCardMapper;
    }

    //    @Autowired
    public void setReaderInfoDao(ReaderInfoMapper readerInfoMapper) {
        this.readerInfoMapper = readerInfoMapper;
    }

    //    @Autowired
    public void setAdminDao(AdminMapper adminMapper) {
        this.adminMapper = adminMapper;
    }

    public boolean hasMatchReader(int readerId,String passwd){
        return  readerCardMapper.getMatchCount(readerId, passwd)>0;
    }

    public ReaderCard findReaderCardByUserId(int readerId){
        return readerCardMapper.findReaderByReaderId(readerId);
    }
    public ReaderInfo findReaderInfoByReaderId(int readerId){
        return readerInfoMapper.findReaderInfoByReaderId(readerId);
    }

    public boolean hasMatchAdmin(int adminId,String password){
        return adminMapper.getMatchCount(adminId,password)==1;
    }

    public boolean adminRePasswd(int adminId,String newPasswd){
        return adminMapper.rePassword(adminId,newPasswd)>0;
    }
    public String getAdminPasswd(int id){
        return adminMapper.getPasswd(id);
    }



}
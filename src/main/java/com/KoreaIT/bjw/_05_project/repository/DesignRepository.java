package com.KoreaIT.bjw._05_project.repository;

import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Select;

import com.KoreaIT.bjw._05_project.vo.Board;

@Mapper
public interface DesignRepository {

	@Select("""
			SELECT *
			FROM design
			WHERE id= #{boardId}
			AND delStatus = 0;
			""")
	Board getBoardById(int boardId);

}
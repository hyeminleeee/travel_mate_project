package xyz.itwill.util;

import lombok.Data;

//페이징 처리 관련 값들을 저장하기 위한 클래스

@Data
public class qnaPager {
    private int pageNum;  // 요청 페이지 번호
    private int pageSize; // 하나의 페이지에 출력될 게시글의 갯수
    private int totalSize; // 전체 게시글의 갯수
    private int blockSize; // 하나의 블럭에 출력될 페이지 번호의 갯수
    private int deletedCount; // 삭제된 게시글 수 추가

    private int totalPage; // 전체 페이지의 갯수
    private int startRow;  // 요청 페이지에 출력될 게시글의 시작 행번호
    private int endRow;    // 요청 페이지에 출력될 게시글의 종료 행번호
    private int startPage; // 현재 블럭에 출력될 시작 페이지 번호
    private int endPage;   // 현재 블럭에 출력될 종료 페이지 번호
    private int prevPage;  // 이전 블럭에 출력될 시작 페이지 번호
    private int nextPage;  // 다음 블럭에 출력될 시작 페이지 번호

    public qnaPager(int pageNum, int pageSize, int totalSize, int blockSize, int deletedCount) {
        this.pageNum = pageNum;
        this.pageSize = pageSize;
        this.totalSize = totalSize - deletedCount; // 삭제된 게시글 수를 제외한 실제 게시글 수
        this.blockSize = blockSize;
        this.deletedCount = deletedCount; // 필드에 삭제된 게시글 수 저장

        calcPaging();
    }

    private void calcPaging() {
        totalPage = (int) Math.ceil((double) totalSize / pageSize);
        if (pageNum <= 0 || pageNum > totalPage) {
            pageNum = 1;
        }

        startRow = (pageNum - 1) * pageSize + 1;
        endRow = pageNum * pageSize;
        if (endRow > totalSize) {
            endRow = totalSize;
        }

        startPage = (pageNum - 1) / blockSize * blockSize + 1;
        endPage = startPage + blockSize - 1;
        if (endPage > totalPage) {
            endPage = totalPage;
        }

        prevPage = startPage - blockSize;
        nextPage = startPage + blockSize;
    }

    public int getDisplayNumber(int indexInPage) {
        return (totalSize ) - ((pageNum - 1) * pageSize + indexInPage);
    }
}
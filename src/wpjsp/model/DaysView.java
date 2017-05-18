package wpjsp.model;

import java.util.List;

public class DaysView {
	
	private int dayTotalCount;
	private int currentPageNumber;
	private List<Days> dayList;
	private int pageTotalCount;
	private int dayCountPerPage;
	private int firstRow;
	private int endRow;

	
	public DaysView(List<Days> dayList,
			int dayTotalCount,		
			int currentPageNumber,		
			int dayCountPerPage,	 
			int startRow,
			int endRow) 
	{
		this.dayList = dayList;
		this.dayTotalCount = dayTotalCount;
		this.currentPageNumber = currentPageNumber;
		this.dayCountPerPage = dayCountPerPage;
		this.firstRow = startRow;
		this.endRow = endRow;

		calculatePageTotalCount();
	}

	private void calculatePageTotalCount() {
		if (dayTotalCount == 0) {
			pageTotalCount = 0;
		} else {
			pageTotalCount = dayTotalCount / dayCountPerPage;
			if (dayTotalCount % dayCountPerPage > 0) {
				pageTotalCount++;
			}
		}
	}

	public int getDayTotalCount() {
		return dayTotalCount;
	}

	public int getCurrentPageNumber() {
		return currentPageNumber;
	}

	public List<Days> getDayList() {
		return dayList;
	}

	public int getPageTotalCount() {
		return pageTotalCount;
	}

	public int getDayCountPerPage() {
		return dayCountPerPage;
	}

	public int getFirstRow() {
		return firstRow;
	}

	public int getEndRow() {
		return endRow;
	}

	public boolean isEmpty() {
		return dayTotalCount == 0;
	}

}

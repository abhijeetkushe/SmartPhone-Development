package net.ioncannon.model;

import org.springframework.web.multipart.commons.CommonsMultipartFile;

/**
 */
public class UploadItem
{
  private String name;
  private CommonsMultipartFile fileData;
	 private String password;
  public String getPassword() {
		return password;
	}

	public void setPassword(String password) {
		this.password = password;
	}

public String getName()
  {
    return name;
  }

  public void setName(String name)
  {
    this.name = name;
  }

  public CommonsMultipartFile getFileData()
  {
    return fileData;
  }

  public void setFileData(CommonsMultipartFile fileData)
  {
    this.fileData = fileData;
  }
}

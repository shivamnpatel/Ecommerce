package com.learn.ecommerce.helper;

public class DescriptionHelper {

	public static String longDescToShort(String desc) {

		String[] splitDec = desc.trim().split(" ");
		String convertedDesc = "";

		if (desc.length() < 10)
		{
			return desc;
		}
		else 
		{
			for (int i = 0; i <10; i++) 
			{
				convertedDesc=convertedDesc+(splitDec[i]+" ");
			}
		}

		return convertedDesc+"...";
	}
}

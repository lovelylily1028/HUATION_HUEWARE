/***********************************************************
 * ��  ��  ��   : ConnectionMonitor.java
 * ��  ��  ��   : 2006. 12. 18
 * ��  ��  ��   : KBS
 *-----------------------------------------------------------
 * ���α׷���   : 
 * ��      ��   : 
 *-----------------------------------------------------------
 * ��  ��  ��   : 
 * ��  ��  ��   : 
 * ����  ����   : 
 ************************************************************/

package com.huation.common;

import java.sql.Connection;
import java.util.ArrayList;

import com.huation.framework.logging.Log;
import com.huation.framework.logging.LogFactory;
import com.huation.framework.util.NumberUtil;

public class ConnectionMonitor {

	private static ConnectionMonitor instance = null;

	private static CheckThread CT = null;

	private static long sleepTime = 1000 * 30 * 1;// Connection ���� �ֱ�

	private static long checkTime = 1000 * 60 * 3;// Connection not closed
													// error ��� �ֱ�

	private static long limitTime = 1000 * 60 * 15;// Connection not closed ����
													// close ���� �ֱ�

	Log log = LogFactory.getLog(getClass());
	private ArrayList conList = null;

	private ArrayList exList = null;

	private ArrayList timeList = null;

	static {

		instance = new ConnectionMonitor();
	}

	public static ConnectionMonitor getInstance() {

		if (instance == null)
			instance = new ConnectionMonitor();

		return instance;
	}

	private ConnectionMonitor() {

		conList = new ArrayList();
		exList = new ArrayList();
		timeList = new ArrayList();
		CT = new CheckThread();

		CT.start();
		
		log.debug("Connection Monitoring Start");
	}

	public void setConnection(Exception ex, Connection con) {

		if (!CT.isAlive()) {

			conList = new ArrayList();
			exList = new ArrayList();
			timeList = new ArrayList();
			CT.start();
		}

		conList.add(con);
		exList.add(ex);
		timeList.add("" + System.currentTimeMillis());
	}

	class CheckThread extends Thread {

		public CheckThread() {
		}

		public void run() {

			try {

				long time = 0;
				Connection con = null;
				long mit = 0;
				long sec = 0;
				boolean isrun = true;

				while (isrun) {

					// System.out.println("Monitoring...................................................................................");

					if (conList == null || conList.size() == 0)
						break;

					for (int n = 0; n < conList.size(); n++) {

						con = (Connection) conList.get(n);

						if (con != null) {

							if (!con.isClosed()) {

								time = System.currentTimeMillis()
										- NumberUtil.parseLong((String) timeList.get(n));

								if (time > (checkTime)) {

									mit = time / 1000 / 60;
									sec = (time - (mit * 1000 * 60)) / 1000;

									if (true && time > limitTime) {// connection
																	// close :
																	// true,
																	// false : x
																	// close.
										System.out.println((mit > 0 ? mit
												+ "�� " : "")
												+ sec
												+ "�ʸ� ����� Connection �� �ֽ��ϴ�.\n"
												+ con);
										log.error( 	(mit > 0 ? mit + "�� "
																: "")
																+ sec
																+ "�ʸ� ����� Connection�� ���� ���� �մϴ�.\n"
																+ con, (Exception) exList
																.get(n));
										con.close();
									} else {

										System.out.println((mit > 0 ? mit
												+ "�� " : "")
												+ sec
												+ "�ʸ� ����� Connection �� �ֽ��ϴ�.\n"
												+ con);
										log.error((mit > 0 ? mit + "�� "
																: "")
																+ sec
																+ "�ʸ� ����� Connection �� �ֽ��ϴ�.\n"
																+ con, (Exception) exList
																.get(n));
									}
								}
							} else {

								conList.remove(n);
								timeList.remove(n);
								exList.remove(n);
								n--;
							}
						} else {

							conList.remove(n);
							timeList.remove(n);
							exList.remove(n);
							n--;
						}

					}

					/*
					 * if(conList.size() > 0)
					 * System.out.println("############################################################################## " +
					 * conList.size());
					 */

					sleep(sleepTime);
				}
			} catch (Exception e) {
				log.error("Connection Monitoring Check Error", e);
			}
		}
	}
}

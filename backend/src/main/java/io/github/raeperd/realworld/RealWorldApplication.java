package io.github.raeperd.realworld;

import org.h2.tools.Server;
import org.springframework.boot.SpringApplication;
import org.springframework.boot.autoconfigure.SpringBootApplication;

import java.sql.SQLException;

@SpringBootApplication
public class RealWorldApplication {

	public static void main(String[] args) throws SQLException {
		// The H2 database lives in memory, inside this JVM. This TCP server lets a database client
		// (e.g. IntelliJ) connect to it with jdbc:h2:tcp://localhost:9092/mem:test
		// Started here rather than in a bean, so that the tests don't open the port.
		Server.createTcpServer("-tcpPort", "9092").start();
		SpringApplication.run(RealWorldApplication.class, args);
	}

}

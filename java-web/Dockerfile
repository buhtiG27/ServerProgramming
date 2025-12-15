# --- build stage: compile Java sources using Tomcat's servlet-api ---
FROM public.ecr.aws/docker/library/tomcat:10.1-jdk21-temurin AS build
WORKDIR /work

# webapp（JSP等）と依存jar
COPY src/main/webapp/ /work/webapp/
COPY src/main/java/ /work/src/

# クラス出力先
RUN mkdir -p /work/classes

# javac compile
# Tomcatに含まれる servlet-api を使う + WEB-INF/lib の jar を classpath に追加
RUN javac -encoding UTF-8 \
    -cp "/usr/local/tomcat/lib/*:/work/webapp/WEB-INF/lib/*" \
    -d /work/classes \
    $(find /work/src -name "*.java")
# RUN set -eux; \
#     javac -Xlint:all -encoding UTF-8 \
#     -cp "/usr/local/tomcat/lib/*:/work/webapp/WEB-INF/lib/*" \
#     -d /work/classes \
#     $(find /work/src -name "*.java") \
#     2>&1 | tee /work/javac.log; \
#     true

# --- runtime stage: Tomcat serving JSP + compiled classes ---
FROM public.ecr.aws/docker/library/tomcat:10.1-jdk21-temurin

# ROOTで動かす
RUN rm -rf /usr/local/tomcat/webapps/*

# webapp配置
COPY --from=build /work/webapp/ /usr/local/tomcat/webapps/ROOT/

# コンパイル済みクラス配置
COPY --from=build /work/classes/ /usr/local/tomcat/webapps/ROOT/WEB-INF/classes/

EXPOSE 8080

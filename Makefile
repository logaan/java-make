# Find all the java files.
JAVA_FILES = $(shell find . -name "*.java")

# Once we know the java file paths we can calculate what the class paths should
# be. We could just do a find name for class files but that would mean that any
# new file that has not yet been compiled wouldn't trigger a build.
CLASS_FILES = $(subst .java,.class,$(JAVA_FILES))

# To build everything we need to have built all the class files.
all: $(CLASS_FILES)

# This target says that any class file depends on a java file of the same name
# and path. The dependency file will be compiled.
%.class : %.java
	javac $<

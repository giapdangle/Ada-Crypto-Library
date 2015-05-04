ADACC=gnatmake
ADACLEAN=gnatclean
SRCDIR = src
DOC= ./doc/
SUBTDIR = test
LIBDIR=lib
MKDIR=mkdir

all: acl 
clean: clean-acl clean-acltest

###########################################################################
################################### ACL ###################################
###########################################################################

acl:
	$(MKDIR) -p $(LIBDIR)
	$(ADACC) -P libadacrypt.gpr

acl-debug:
	$(MKDIR) -p $(LIBDIR)
	$(ADACC) -P libadacrypt.gpr -Xmode=debug

clean-acl:
	$(ADACLEAN) -P libadacrypt.gpr


###########################################################################
################################### TEST ##################################
###########################################################################

acltest:	
	$(ADACC) -P acltest.gpr

clean-acltest:
	$(ADACLEAN) -P acltest.gpr
	$(MAKE) -C $(SUBTDIR) clean

gcov:
	$(MAKE) -C $(SRCDIR) gcov
	$(MAKE) -C $(SUBTDIR) gcov

###########################################################################
############################## DOCUMENTATION ##############################
###########################################################################

docu:
	$(MAKE) -C $(DOC) all

install-docu:
	$(MAKE) -C $(DOC) install	

unistall-docu:
	$(MAKE) -C $(DOC) uninstall	

clean-docu:
	$(MAKE) -C $(DOC) clean


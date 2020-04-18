# **************************************************************************** #
#                                   BINARIES                                   #
# **************************************************************************** #

NAME		= n_puzzle

# **************************************************************************** #
#                                  COMPILATION                                 #
# **************************************************************************** #

CC 			= g++
CFLAGS		= #-Wall -Wextra -Werror

FSAN		= #-fsanitize=address
DEBUG		= #-g3
OPTI		= #-O2

# **************************************************************************** #
#                                 DIRECTORIES                                  #
# **************************************************************************** #

SRCDIR		= srcs
OBJDIR		= .objs
INCDIR		= srcs

# **************************************************************************** #
#                                 INCLUDES                                     #
# **************************************************************************** #

# **************************************************************************** #
#                                  SOURCES                                     #
# **************************************************************************** #

SRCS 		=	board.cpp		\
				closed_list.cpp	\
				goal.cpp		\
				heuristics.cpp	\
				lexer.cpp		\
				main.cpp		\
				open_list.cpp

# **************************************************************************** #
#                                   UTILS                                      #
# **************************************************************************** #

OBJS		= $(addprefix $(OBJDIR)/, $(SRCS:.cpp=.o))

DPDCS		= $(OBJS:.o=.d)

# **************************************************************************** #
#                                   RULES                                      #
# **************************************************************************** #

all				:
	@make -j $(NAME)

$(NAME)			: $(OBJS)
	@$(CC) $(CFLAGS) $(DEBUG) $(OPTI) $(FSAN) -o $@ $^
	@echo "\n\033[36mCreation :\033[0m \033[35;4m$(NAME)\033[0m\n"

-include $(DPDCS)

$(OBJDIR)/%.o	: $(SRCDIR)/%.cpp | $(OBJDIR)
	@$(CC) $(CFLAGS) $(DEBUG) $(OPTI) $(FSAN) -I $(INCDIR) -MMD -o $@ -c $<
	@echo "\033[36mCompilation :\033[0m \033[32m$*\033[0m"

$(OBJDIR):
	@mkdir -p $@ 2> /dev/null || true

clean			:
	@rm -rf $(OBJDIR)
	@echo "\n\033[36mDeletion :\033[0m \033[32mObjects\033[0m\n"

fclean			:
	@make clean
	@rm -rf $(NAME)
	@echo "\033[36mDeletion :\033[0m \033[35;4m$(NAME)\033[0m\n"

cm				:
	@make clean
	@make all

re				:
	@make fclean
	@make all

.PHONY			: all clean fclean cm re

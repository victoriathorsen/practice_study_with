module UsersHelper

    def count_commented_posts
        if count == 1
            "You left comments on #{@user.commented_posts.count} post"
        else
            "You left comments on #{@user.commented_posts.count} post".pluarlize
        end
    end

end

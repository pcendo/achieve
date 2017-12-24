class BlogMailer < ApplicationMailer

    def blog_mail(blog)
        @blog = blog
        @user = User.find(@blog.user_id)
        @email = ["endo9634@gmail.com", @user.email]
        mail to: @email, subject: "BLOG作成の確認メール"
    end

end

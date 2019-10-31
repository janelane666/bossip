class SessionsController < ApplicationController
	
	# permet la création d'une session se fera au travers de la page de login où l'on demande mot de passe et email. 
	def new
	end

	# puis create va s'occuper d'essayer d'authentifier l'utilisateur avec le couple email-mot de passe. 
	# Si ce dernier est bien authentifié, nous stockerons l'info avec session[:user_id] = user.id. 
	# S'il n'est pas bien authentifié, on fera un render de la page de login avec les messages d'erreur.
	# Une fois l'utilisateur connecté, ce sera très simple de retrouver notre utilisateur grâce à User.find(session[:user_id])
	# cherche s'il existe un utilisateur en base avec l’e-mail
	def create
		@user = User.find_by(email: params[:email])

		# on vérifie si l'utilisateur existe bien ET si on arrive à l'authentifier (méthode bcrypt) avec le mot de passe 
		if @user && @user.authenticate(params[:password])
			session[:user_id] = user.id
			# redirige où tu veux, avec un flash ou pas
		else
			flash.now[:danger] = 'Invalid email/password combination'
			render 'new'
		end
	end

	# permet de fermer la session
	def destroy
		session.delete(:user_id)
	end

end

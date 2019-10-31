class GossipsController < ApplicationController

  # Méthode qui récupère tous les potins et les envoie à la view index (index.html.erb) pour affichage
  def index
    @first_name = params[:first_name]

    # on fait une boucle pour stocker les infos dans l'index et l'afficher
    @gossips = []
    Gossip.all.each do |gossip|
      @gossips << {
        id: gossip.id,
        title: gossip.title,
        author: gossip.user.first_name, 
        author_id: gossip.user.id
      }
    end
  end

  # Méthode qui récupère le potin concerné et l'envoie à la view show (show.html.erb) pour affichage
  def show
    my_gossip = Gossip.find(params[:id])
    @gossip = {id: my_gossip.id, author: my_gossip.user.first_name, title: my_gossip.title, user_id: my_gossip.user.id, content: my_gossip.content, created_at: my_gossip.created_at}
  end

  # Méthode qui crée un potin vide et l'envoie à une view qui affiche le formulaire pour 'le remplir' (new.html.erb)
  def new
    @gossip = Gossip.new
  end

  # Méthode qui créé un potin à partir du contenu du formulaire de new.html.erb, soumis par l'utilisateur
  # pour info, le contenu de ce formulaire sera accessible dans le hash params (ton meilleur pote)
  # Une fois la création faite, on redirige généralement vers la méthode show (pour afficher le potin créé)
  def create
    my_gossip = {author: params[:author], content: params[:content], title: params[:title]}
    @gossip = Gossip.new(title: my_gossip[:title], content: my_gossip[:content], user_id: 11)

    respond_to do |format|
      if @gossip.save
        format.html { redirect_to @gossip, notice: 'Ton potin a bien été créé' }
        format.json { render :show, status: :created, location: @gossip }
      else
        format.html { render :new }
        format.json { render json: @gossip.errors, status: :unprocessable_entity }
      end
    end
  end
  
  # Méthode qui met à jour le potin à partir du contenu du formulaire de edit.html.erb, soumis par l'utilisateur
  # pour info, le contenu de ce formulaire sera accessible dans le hash params
  # Une fois la modification faite, on redirige généralement vers la méthode show (pour afficher le potin modifié)
  def update
    @gossip= Gossip.find(params[:id])
    @gossip.update(gossip_params)

    redirect_to gossips_path
  end

  # Méthode qui récupère le potin concerné et l'envoie à la view edit (edit.html.erb) pour affichage dans un formulaire d'édition
  def edit
    @gossip= Gossip.find(params[:id])
  end

  # Méthode qui récupère le potin concerné et le détruit en base
  # Une fois la suppression faite, on redirige généralement vers la méthode index (pour afficher la liste à jour)
  def destroy
    @gossip= Gossip.find(params[:id])
    @gossip.destroy
    redirect_to gossips_path
  end

   # Use callbacks to share common setup or constraints between actions.
  def set_gossip
    @article = Article.find(params[:id])
  end
  # Never trust parameters from the scary internet, only allow the white list through.
  def gossip_params
    params.require(:gossip).permit(:name, :content)
  end

end

public interface IInteractable
{
    void Interact(Player.Player player);
}
public interface IDialog
{
    string Dialog { get; set; }
}
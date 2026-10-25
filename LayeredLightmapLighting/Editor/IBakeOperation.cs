// Only replace your existing file if its members differ.
public interface IBakeOperation
{
    string DisplayName { get; }
    bool IsBaked { get; }
    string GetStatus();
    (int count, bool warn) GetSliceInfo();
    void Bake();
    void Delete();
}
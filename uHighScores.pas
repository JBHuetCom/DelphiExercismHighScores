unit uHighScores;

interface

  uses
    System.SysUtils, System.Generics.Collections;

  type IScores = interface
    function Scores : TList<integer>;
    function Highest() : integer;
    function Latest() : integer;
    function personalTopThree() : TList<integer>;
    function Report() : string;
  end;

  type TScores = class(TInterfacedObject, IScores)
    constructor Create(AValuesArray : TArray<integer>); overload;
    destructor Destroy; override;
    function Scores : TList<integer>;
    function Highest() : integer;
    function Latest() : integer;
    function personalTopThree() : TList<integer>;
    function Report() : string;
  private
    FScores : TList<integer>;
    FSortedScores : TList<integer>;
    FPersonalTopThreeScores : TList<integer>;
  end;

  function NewScores(AScoresArray : TArray<integer>) : TScores;

implementation

  constructor TScores.Create(AValuesArray : TArray<integer>);
    var
      i, VItemCount : integer;
      VTempList : TList<integer>;
    begin
      inherited Create;
      self.FScores := TList<integer>.Create;
      self.FSCores.AddRange(AValuesArray);
      self.FSortedScores := TList<integer>.Create;
      self.FSortedScores.AddRange(AValuesArray);
      self.FSortedScores.Sort;
      VTempList := TList<integer>.Create;
      VTempList.AddRange(self.FSCores);
      VTempList.Sort;
      VTempList.Reverse;
      VItemCount := 3;
      if VTempList.Count < 3 then
        VItemCount := VTempList.Count;
      self.FPersonalTopThreeScores := TList<integer>.Create;
      if 0 < VItemCount then
        for i := 0 to (VItemCount - 1) do
          self.FPersonalTopThreeScores.Add(VTempList.Items[i]);
      VTempList.Free;
    end;

  function TScores.Scores : TList<integer>;
    begin
      Result := self.FScores;
    end;

  function TScores.Highest() : integer;
    begin
      Result := self.FSortedScores.Last;
    end;

  function TScores.Latest() : integer;
    begin
      Result := self.FScores.Last;
    end;

  function TScores.personalTopThree() : TList<integer>;
    begin
      Result := self.FPersonalTopThreeScores;
    end;

  function TScores.Report() : string;
    var
      ScoreGap : integer;
      ScoreGapText : string;
    begin
      SCoreGap := self.FSortedScores.Last - self.FScores.Last;
      ScoreGapText := '';
      if 0 < ScoreGap then
        ScoreGapText := ScoreGap.ToString + ' short of ';
      Result := 'Your latest score was ' + self.FScores.Last.ToString + '. That''s ' + ScoreGapText + 'your personal best!';
    end;

  destructor TScores.Destroy;
    begin
      self.FPersonalTopThreeScores.Free;
      self.FSortedScores.Free;
      self.FScores.Free;
      inherited;
    end;

  function NewScores(AScoresArray : TArray<integer>) : TScores;
    begin
      Result := Tscores.Create(AScoresArray);
    end;

end.

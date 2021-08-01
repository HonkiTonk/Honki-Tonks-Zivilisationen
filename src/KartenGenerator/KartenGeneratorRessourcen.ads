pragma SPARK_Mode (On);

with GlobaleDatentypen, GlobaleRecords;

package KartenGeneratorRessourcen is

   procedure GenerierungRessourcen;

private
   
   type WahrscheinlichkeitRessourceArray is array (GlobaleDatentypen.Karten_Ressourcen_Reichtum_Vorhanden_Enum'Range, GlobaleDatentypen.Karten_Grund_Ressourcen_Enum'Range) of Float;
   WahrscheinlichkeitRessourcen : constant WahrscheinlichkeitRessourceArray := (
                                                                                GlobaleDatentypen.Arm =>
                                                                                  (
                                                                                   GlobaleDatentypen.Fisch              => 0.08,
                                                                                   GlobaleDatentypen.Wal                => 0.02,
                                                                                   GlobaleDatentypen.Kohle              => 0.08,
                                                                                   GlobaleDatentypen.Eisen              => 0.08,
                                                                                   GlobaleDatentypen.Öl                 => 0.08,
                                                                                   GlobaleDatentypen.Hochwertiger_Boden => 0.08,
                                                                                   GlobaleDatentypen.Gold               => 0.02
                                                                                  ),
                                                                                
                                                                                GlobaleDatentypen.Wenig =>
                                                                                  (
                                                                                   GlobaleDatentypen.Fisch              => 0.08,
                                                                                   GlobaleDatentypen.Wal                => 0.02,
                                                                                   GlobaleDatentypen.Kohle              => 0.08,
                                                                                   GlobaleDatentypen.Eisen              => 0.08,
                                                                                   GlobaleDatentypen.Öl                 => 0.08,
                                                                                   GlobaleDatentypen.Hochwertiger_Boden => 0.08,
                                                                                   GlobaleDatentypen.Gold               => 0.02
                                                                                  ),
                                                                                
                                                                                GlobaleDatentypen.Mittel =>
                                                                                  (
                                                                                   GlobaleDatentypen.Fisch              => 0.08,
                                                                                   GlobaleDatentypen.Wal                => 0.02,
                                                                                   GlobaleDatentypen.Kohle              => 0.08,
                                                                                   GlobaleDatentypen.Eisen              => 0.08,
                                                                                   GlobaleDatentypen.Öl                 => 0.08,
                                                                                   GlobaleDatentypen.Hochwertiger_Boden => 0.08,
                                                                                   GlobaleDatentypen.Gold               => 0.02
                                                                                  ),
                                                                                
                                                                                GlobaleDatentypen.Viel =>
                                                                                  (
                                                                                   GlobaleDatentypen.Fisch              => 0.08,
                                                                                   GlobaleDatentypen.Wal                => 0.02,
                                                                                   GlobaleDatentypen.Kohle              => 0.08,
                                                                                   GlobaleDatentypen.Eisen              => 0.08,
                                                                                   GlobaleDatentypen.Öl                 => 0.08,
                                                                                   GlobaleDatentypen.Hochwertiger_Boden => 0.08,
                                                                                   GlobaleDatentypen.Gold               => 0.02
                                                                                  ),
                                                                                
                                                                                GlobaleDatentypen.Überfluss =>
                                                                                  (
                                                                                   GlobaleDatentypen.Fisch              => 0.08,
                                                                                   GlobaleDatentypen.Wal                => 0.02,
                                                                                   GlobaleDatentypen.Kohle              => 0.08,
                                                                                   GlobaleDatentypen.Eisen              => 0.08,
                                                                                   GlobaleDatentypen.Öl                 => 0.08,
                                                                                   GlobaleDatentypen.Hochwertiger_Boden => 0.08,
                                                                                   GlobaleDatentypen.Gold               => 0.02
                                                                                  )
                                                                               );
   
   KartenWert : GlobaleRecords.AchsenKartenfeldPositivRecord;
   
   procedure RessourcenWasser
     (PositionExtern : in GlobaleRecords.AchsenKartenfeldPositivRecord);
   
   procedure RessourcenLand
     (PositionExtern : in GlobaleRecords.AchsenKartenfeldPositivRecord);
   
   procedure RessourcenUmgebungBelegen
     (PositionExtern : in GlobaleRecords.AchsenKartenfeldPositivRecord);

end KartenGeneratorRessourcen;

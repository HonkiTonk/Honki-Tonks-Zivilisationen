pragma SPARK_Mode (On);

with GlobaleDatentypen, GlobaleRecords;

package KartenGeneratorRessourcen is

   procedure GenerierungRessourcen;

private
   
   type WahrscheinlichkeitRessourceArray is array (GlobaleDatentypen.Karten_Ressourcen_Reichtum_Verwendet_Enum'Range, GlobaleDatentypen.Karten_Grund_Ressourcen_Enum'Range) of Float;
   WahrscheinlichkeitRessourcen : constant WahrscheinlichkeitRessourceArray := (
                                                                                GlobaleDatentypen.Arm =>
                                                                                  (
                                                                                   GlobaleDatentypen.Fisch              => 0.02,
                                                                                   GlobaleDatentypen.Wal                => 0.00,
                                                                                   GlobaleDatentypen.Kohle              => 0.02,
                                                                                   GlobaleDatentypen.Eisen              => 0.02,
                                                                                   GlobaleDatentypen.Öl                 => 0.02,
                                                                                   GlobaleDatentypen.Hochwertiger_Boden => 0.02,
                                                                                   GlobaleDatentypen.Gold               => 0.00
                                                                                  ),
                                                                                
                                                                                GlobaleDatentypen.Wenig =>
                                                                                  (
                                                                                   GlobaleDatentypen.Fisch              => 0.04,
                                                                                   GlobaleDatentypen.Wal                => 0.01,
                                                                                   GlobaleDatentypen.Kohle              => 0.04,
                                                                                   GlobaleDatentypen.Eisen              => 0.04,
                                                                                   GlobaleDatentypen.Öl                 => 0.04,
                                                                                   GlobaleDatentypen.Hochwertiger_Boden => 0.04,
                                                                                   GlobaleDatentypen.Gold               => 0.01
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
                                                                                   GlobaleDatentypen.Fisch              => 0.16,
                                                                                   GlobaleDatentypen.Wal                => 0.04,
                                                                                   GlobaleDatentypen.Kohle              => 0.16,
                                                                                   GlobaleDatentypen.Eisen              => 0.16,
                                                                                   GlobaleDatentypen.Öl                 => 0.16,
                                                                                   GlobaleDatentypen.Hochwertiger_Boden => 0.16,
                                                                                   GlobaleDatentypen.Gold               => 0.04
                                                                                  ),
                                                                                
                                                                                GlobaleDatentypen.Überfluss =>
                                                                                  (
                                                                                   GlobaleDatentypen.Fisch              => 0.32,
                                                                                   GlobaleDatentypen.Wal                => 0.08,
                                                                                   GlobaleDatentypen.Kohle              => 0.32,
                                                                                   GlobaleDatentypen.Eisen              => 0.32,
                                                                                   GlobaleDatentypen.Öl                 => 0.32,
                                                                                   GlobaleDatentypen.Hochwertiger_Boden => 0.32,
                                                                                   GlobaleDatentypen.Gold               => 0.08
                                                                                  )
                                                                               );
   
   KartenWert : GlobaleRecords.AchsenKartenfeldPositivRecord;
   
   procedure RessourcenGenerierung
     (EbeneExtern : in GlobaleDatentypen.EbeneVorhanden);
   
   procedure RessourcenWasser
     (PositionExtern : in GlobaleRecords.AchsenKartenfeldPositivRecord);
   
   procedure RessourcenLand
     (PositionExtern : in GlobaleRecords.AchsenKartenfeldPositivRecord);
   
   procedure RessourcenUmgebungBelegen
     (PositionExtern : in GlobaleRecords.AchsenKartenfeldPositivRecord);

end KartenGeneratorRessourcen;

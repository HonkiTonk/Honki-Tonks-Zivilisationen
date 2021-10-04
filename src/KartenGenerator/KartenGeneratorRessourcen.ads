pragma SPARK_Mode (On);

with GlobaleDatentypen, KartenRecords, KartenDatentypen;

package KartenGeneratorRessourcen is

   procedure GenerierungRessourcen;

private
   
   type WahrscheinlichkeitRessourceArray is array (KartenDatentypen.Karten_Ressourcen_Reichtum_Verwendet_Enum'Range, KartenDatentypen.Karten_Grund_Ressourcen_Enum'Range) of Float;
   WahrscheinlichkeitRessourcen : constant WahrscheinlichkeitRessourceArray := (
                                                                                KartenDatentypen.Arm =>
                                                                                  (
                                                                                   KartenDatentypen.Fisch              => 0.02,
                                                                                   KartenDatentypen.Wal                => 0.00,
                                                                                   KartenDatentypen.Kohle              => 0.02,
                                                                                   KartenDatentypen.Eisen              => 0.02,
                                                                                   KartenDatentypen.Öl                 => 0.02,
                                                                                   KartenDatentypen.Hochwertiger_Boden => 0.02,
                                                                                   KartenDatentypen.Gold               => 0.00
                                                                                  ),
                                                                                
                                                                                KartenDatentypen.Wenig =>
                                                                                  (
                                                                                   KartenDatentypen.Fisch              => 0.04,
                                                                                   KartenDatentypen.Wal                => 0.01,
                                                                                   KartenDatentypen.Kohle              => 0.04,
                                                                                   KartenDatentypen.Eisen              => 0.04,
                                                                                   KartenDatentypen.Öl                 => 0.04,
                                                                                   KartenDatentypen.Hochwertiger_Boden => 0.04,
                                                                                   KartenDatentypen.Gold               => 0.01
                                                                                  ),
                                                                                
                                                                                KartenDatentypen.Mittel =>
                                                                                  (
                                                                                   KartenDatentypen.Fisch              => 0.08,
                                                                                   KartenDatentypen.Wal                => 0.02,
                                                                                   KartenDatentypen.Kohle              => 0.08,
                                                                                   KartenDatentypen.Eisen              => 0.08,
                                                                                   KartenDatentypen.Öl                 => 0.08,
                                                                                   KartenDatentypen.Hochwertiger_Boden => 0.08,
                                                                                   KartenDatentypen.Gold               => 0.02
                                                                                  ),
                                                                                
                                                                                KartenDatentypen.Viel =>
                                                                                  (
                                                                                   KartenDatentypen.Fisch              => 0.16,
                                                                                   KartenDatentypen.Wal                => 0.04,
                                                                                   KartenDatentypen.Kohle              => 0.16,
                                                                                   KartenDatentypen.Eisen              => 0.16,
                                                                                   KartenDatentypen.Öl                 => 0.16,
                                                                                   KartenDatentypen.Hochwertiger_Boden => 0.16,
                                                                                   KartenDatentypen.Gold               => 0.04
                                                                                  ),
                                                                                
                                                                                KartenDatentypen.Überfluss =>
                                                                                  (
                                                                                   KartenDatentypen.Fisch              => 0.32,
                                                                                   KartenDatentypen.Wal                => 0.08,
                                                                                   KartenDatentypen.Kohle              => 0.32,
                                                                                   KartenDatentypen.Eisen              => 0.32,
                                                                                   KartenDatentypen.Öl                 => 0.32,
                                                                                   KartenDatentypen.Hochwertiger_Boden => 0.32,
                                                                                   KartenDatentypen.Gold               => 0.08
                                                                                  )
                                                                               );
   
   KartenWert : KartenRecords.AchsenKartenfeldPositivRecord;
   
   procedure RessourcenGenerierung
     (EbeneExtern : in KartenDatentypen.EbeneVorhanden);
   
   procedure RessourcenWasser
     (PositionExtern : in KartenRecords.AchsenKartenfeldPositivRecord);
   
   procedure RessourcenLand
     (PositionExtern : in KartenRecords.AchsenKartenfeldPositivRecord);
   
   procedure RessourcenUmgebungBelegen
     (PositionExtern : in KartenRecords.AchsenKartenfeldPositivRecord);

end KartenGeneratorRessourcen;

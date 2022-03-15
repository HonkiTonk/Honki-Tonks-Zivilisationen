pragma SPARK_Mode (On);
pragma Warnings (Off, "*array aggregate*");

with SystemDatentypen; use SystemDatentypen;
with KartenGrundDatentypen; use KartenGrundDatentypen;
with KartenVerbesserungDatentypen;
with GlobaleVariablen;
with EinheitStadtDatentypen;
with EinheitenKonstanten;
with SystemKonstanten;
with KartenGrundKonstanten;

package FarbgebungKonsole is

   procedure Farben
     (EinheitIDExtern : in EinheitStadtDatentypen.EinheitenIDMitNullWert;
      VerbesserungExtern : in KartenVerbesserungDatentypen.Karten_Verbesserung_Enum;
      RessourceExtern : in KartenGrundDatentypen.Karten_Grund_Enum;
      GrundExtern : in KartenGrundDatentypen.Karten_Grund_Enum;
      CursorExtern : in Boolean;
      EigeneRasseExtern : in SystemDatentypen.Rassen_Enum;
      RasseExtern : in SystemDatentypen.Rassen_Enum)
     with
       Pre =>
         ((if EigeneRasseExtern /= EinheitenKonstanten.LeerRasse then GlobaleVariablen.RassenImSpiel (EigeneRasseExtern) = SystemKonstanten.SpielerMenschKonstante)
          and
            (if RasseExtern /= EinheitenKonstanten.LeerRasse then GlobaleVariablen.RassenImSpiel (RasseExtern) /= SystemKonstanten.LeerSpielerKonstante));
   
private
   
   type FeldfarbeArray is array (KartenGrundDatentypen.Karten_Grund_Alle_Felder_Enum'Range) of Wide_Wide_String (1 .. 17);
   Feldfarbe : FeldfarbeArray := (
                                   KartenGrundKonstanten.EisKonstante | KartenGrundKonstanten.UnterwasserEisKonstante                       => "48;2;255;245;238m",
                                   KartenGrundKonstanten.WasserKonstante | KartenGrundKonstanten.UnterwasserWasserKonstante                 => "48;2;000;000;205m",
                                   KartenGrundKonstanten.FlachlandKonstante                                                                 => "48;2;100;160;060m",
                                   KartenGrundKonstanten.TundraKonstante                                                                    => "48;2;205;200;177m",
                                   KartenGrundKonstanten.WüsteKonstante | KartenGrundKonstanten.SandKonstante                               => "48;2;238;238;000m",
                                   KartenGrundKonstanten.HügelKonstante                                                                     => "48;2;205;133;063m",
                                   KartenGrundKonstanten.GebirgeKonstante                                                                   => "48;2;120;120;120m",
                                   KartenGrundKonstanten.WaldKonstante                                                                      => "48;2;030;130;030m",
                                   KartenGrundKonstanten.DschungelKonstante                                                                 => "48;2;000;070;000m",
                                   KartenGrundKonstanten.KüstengewässerKonstante | KartenGrundKonstanten.UnterwasserKüstengewässerKonstante => "48;2;135;206;250m",
                                   KartenGrundKonstanten.SumpfKonstante                                                                     => "48;2;000;040;000m",
                                   KartenGrundKonstanten.ErdeKonstante                                                                      => "48;2;139;069;019m",
                                   KartenGrundKonstanten.ErdgesteinKonstante                                                                => "48;2;120;120;120m",
                                   KartenGrundKonstanten.LavaKonstante                                                                      => "48;2;250;039;039m",
                                   KartenGrundKonstanten.WolkenKonstante                                                                    => "48;2;236;236;236m",
                                   KartenGrundKonstanten.WeltraumKonstante                                                                  => "48;2;127;127;127m",
                                   KartenGrundKonstanten.GesteinKonstante                                                                   => "48;2;087;087;087m",
                                   KartenGrundKonstanten.PlanetenkernKonstante                                                              => "48;2;205;000;000m",
                                   KartenGrundKonstanten.UnterwasserWaldKonstante                                                           => "48;2;127;255;212m",
                                   KartenGrundKonstanten.KorallenKonstante                                                                  => "48;2;255;114;086m",
                                   KartenGrundKonstanten.HügelMitKonstante                                                                  => "48;2;000;000;000m"
                                  );
   
   procedure FarbenCursorEinheitVerbesserung
     (EinheitIDExtern : in EinheitStadtDatentypen.EinheitenIDMitNullWert;
      VerbesserungExtern : in KartenVerbesserungDatentypen.Karten_Verbesserung_Enum;
      RessourceExtern : in KartenGrundDatentypen.Karten_Grund_Enum;
      GrundExtern : in KartenGrundDatentypen.Karten_Grund_Enum;
      CursorExtern : in Boolean;
      EigeneRasseExtern : in SystemDatentypen.Rassen_Enum;
      RasseExtern : in SystemDatentypen.Rassen_Enum);
   
   procedure FarbenRessourcenFluss
     (GrundExtern : in KartenGrundDatentypen.Karten_Grund_Enum;
      RessourceExtern : in KartenGrundDatentypen.Karten_Grund_Enum);
   
   procedure FarbenFeld
     (GrundExtern : in KartenGrundDatentypen.Karten_Grund_Alle_Felder_Enum)
     with
       Pre =>
         (GrundExtern /= KartenGrundKonstanten.HügelMitKonstante);

end FarbgebungKonsole;

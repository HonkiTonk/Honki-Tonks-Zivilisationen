pragma SPARK_Mode (On);
pragma Warnings (Off, "*array aggregate*");

with SystemDatentypen; use SystemDatentypen;
with KartenGrundDatentypen; use KartenGrundDatentypen;
with KartenVerbesserungDatentypen;
with GlobaleVariablen;
with EinheitStadtDatentypen;
with EinheitenKonstanten;

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
         ((if EigeneRasseExtern /= EinheitenKonstanten.LeerRasse then GlobaleVariablen.RassenImSpiel (EigeneRasseExtern) = SystemDatentypen.Spieler_Mensch_Enum)
          and
            (if RasseExtern /= EinheitenKonstanten.LeerRasse then GlobaleVariablen.RassenImSpiel (RasseExtern) /= SystemDatentypen.Leer_Spieler_Enum));
   
private
   
   type FeldfarbeArray is array (KartenGrundDatentypen.Karten_Grund_Alle_Felder_Enum'Range) of Wide_Wide_String (1 .. 17);
   Feldfarbe : FeldfarbeArray := (
                                   KartenGrundDatentypen.Eis_Enum | KartenGrundDatentypen.Unterwasser_Eis_Enum                       => "48;2;255;245;238m",
                                   KartenGrundDatentypen.Wasser_Enum | KartenGrundDatentypen.Unterwasser_Wasser_Enum                 => "48;2;000;000;205m",
                                   KartenGrundDatentypen.Flachland_Enum                                                                 => "48;2;100;160;060m",
                                   KartenGrundDatentypen.Tundra_Enum                                                                    => "48;2;205;200;177m",
                                   KartenGrundDatentypen.Wüste_Enum | KartenGrundDatentypen.Sand_Enum                               => "48;2;238;238;000m",
                                   KartenGrundDatentypen.Hügel_Enum                                                                     => "48;2;205;133;063m",
                                   KartenGrundDatentypen.Gebirge_Enum                                                                   => "48;2;120;120;120m",
                                   KartenGrundDatentypen.Wald_Enum                                                                      => "48;2;030;130;030m",
                                   KartenGrundDatentypen.Dschungel_Enum                                                                 => "48;2;000;070;000m",
                                   KartenGrundDatentypen.Küstengewässer_Enum | KartenGrundDatentypen.Unterwasser_Küstengewässer_Enum => "48;2;135;206;250m",
                                   KartenGrundDatentypen.Sumpf_Enum                                                                     => "48;2;000;040;000m",
                                   KartenGrundDatentypen.Erde_Enum                                                                      => "48;2;139;069;019m",
                                   KartenGrundDatentypen.Erdgestein_Enum                                                                => "48;2;120;120;120m",
                                   KartenGrundDatentypen.Lava_Enum                                                                      => "48;2;250;039;039m",
                                   KartenGrundDatentypen.Wolken_Enum                                                                    => "48;2;236;236;236m",
                                   KartenGrundDatentypen.Weltraum_Enum                                                                  => "48;2;127;127;127m",
                                   KartenGrundDatentypen.Gestein_Enum                                                                   => "48;2;087;087;087m",
                                   KartenGrundDatentypen.Planetenkern_Enum                                                              => "48;2;205;000;000m",
                                   KartenGrundDatentypen.Unterwasser_Wald_Enum                                                           => "48;2;127;255;212m",
                                   KartenGrundDatentypen.Korallen_Enum                                                                  => "48;2;255;114;086m",
                                   KartenGrundDatentypen.Hügel_Mit_Enum                                                                  => "48;2;000;000;000m"
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
         (GrundExtern /= KartenGrundDatentypen.Hügel_Mit_Enum);

end FarbgebungKonsole;

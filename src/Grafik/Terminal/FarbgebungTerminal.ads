pragma SPARK_Mode (On);
pragma Warnings (Off, "*array aggregate*");

with KartengrundDatentypen; use KartengrundDatentypen;
with RassenDatentypen; use RassenDatentypen;
with KartenVerbesserungDatentypen;
with SpielVariablen;
with EinheitenDatentypen;
with EinheitenKonstanten;

package FarbgebungTerminal is

   procedure Farben
     (EinheitIDExtern : in EinheitenDatentypen.EinheitenIDMitNullWert;
      VerbesserungExtern : in KartenVerbesserungDatentypen.Karten_Verbesserung_Enum;
      WegExtern : in KartenVerbesserungDatentypen.Karten_Weg_Enum;
      GrundExtern : in KartengrundDatentypen.Kartengrund_Enum;
      FlussExtern : in KartengrundDatentypen.Kartenfluss_Enum;
      RessourceExtern : in KartengrundDatentypen.Kartenressourcen_Enum;
      CursorExtern : in Boolean;
      EigeneRasseExtern : in RassenDatentypen.Rassen_Enum;
      RasseExtern : in RassenDatentypen.Rassen_Enum)
     with
       Pre => (
               (if EigeneRasseExtern /= EinheitenKonstanten.LeerRasse then SpielVariablen.RassenImSpiel (EigeneRasseExtern) = RassenDatentypen.Mensch_Spieler_Enum)
               and
                 (if RasseExtern /= EinheitenKonstanten.LeerRasse then SpielVariablen.RassenImSpiel (RasseExtern) /= RassenDatentypen.Leer_Spieler_Enum)
              );
   
private
   
   type FeldfarbeArray is array (KartengrundDatentypen.Kartengrund_Vorhanden_Enum'Range) of Wide_Wide_String (1 .. 17);
   Feldfarbe : FeldfarbeArray := (
                                  KartengrundDatentypen.Eis_Enum | KartengrundDatentypen.Untereis_Enum                       => "48;2;255;245;238m",
                                  KartengrundDatentypen.Wasser_Enum | KartengrundDatentypen.Meeresgrund_Enum                 => "48;2;000;000;205m",
                                  KartengrundDatentypen.Flachland_Enum                                                       => "48;2;100;160;060m",
                                  KartengrundDatentypen.Tundra_Enum                                                          => "48;2;205;200;177m",
                                  KartengrundDatentypen.Wüste_Enum | KartengrundDatentypen.Sand_Enum                         => "48;2;238;238;000m",
                                  KartengrundDatentypen.Hügel_Enum                                                           => "48;2;205;133;063m",
                                  KartengrundDatentypen.Gebirge_Enum                                                         => "48;2;120;120;120m",
                                  KartengrundDatentypen.Wald_Enum                                                            => "48;2;030;130;030m",
                                  KartengrundDatentypen.Dschungel_Enum                                                       => "48;2;000;070;000m",
                                  KartengrundDatentypen.Küstengewässer_Enum | KartengrundDatentypen.Küstengrund_Enum         => "48;2;135;206;250m",
                                  KartengrundDatentypen.Sumpf_Enum                                                           => "48;2;000;040;000m",
                                  KartengrundDatentypen.Erde_Enum                                                            => "48;2;139;069;019m",
                                  KartengrundDatentypen.Erdgestein_Enum                                                      => "48;2;120;120;120m",
                                  KartengrundDatentypen.Lava_Enum                                                            => "48;2;250;039;039m",
                                  KartengrundDatentypen.Wolken_Enum                                                          => "48;2;236;236;236m",
                                  KartengrundDatentypen.Weltraum_Enum                                                        => "48;2;127;127;127m",
                                  KartengrundDatentypen.Gestein_Enum                                                         => "48;2;087;087;087m",
                                  KartengrundDatentypen.Planetenkern_Enum                                                    => "48;2;205;000;000m",
                                  KartengrundDatentypen.Unterwald_Enum                                                       => "48;2;127;255;212m",
                                  KartengrundDatentypen.Korallen_Enum                                                        => "48;2;255;114;086m",
                                  KartengrundDatentypen.Magnesiowüstit_Enum                                                  => "48;2;000;000;000m",
                                  KartengrundDatentypen.Perowskit_Enum                                                       => "48;2;000;000;000m",
                                  KartengrundDatentypen.Majorit_Enum                                                         => "48;2;000;000;000m",
                                  KartengrundDatentypen.Ringwoodit_Enum                                                      => "48;2;000;000;000m",
                                  KartengrundDatentypen.Vernichtet_Enum                                                      => "48;2;000;000;000m"
                                 );
   
   procedure FarbenCursorEinheitVerbesserung
     (EinheitIDExtern : in EinheitenDatentypen.EinheitenIDMitNullWert;
      VerbesserungExtern : in KartenVerbesserungDatentypen.Karten_Verbesserung_Enum;
      WegExtern : in KartenVerbesserungDatentypen.Karten_Weg_Enum;
      GrundExtern : in KartengrundDatentypen.Kartengrund_Enum;
      FlussExtern : in KartengrundDatentypen.Kartenfluss_Enum;
      RessourceExtern : in KartengrundDatentypen.Kartenressourcen_Enum;
      CursorExtern : in Boolean;
      EigeneRasseExtern : in RassenDatentypen.Rassen_Enum;
      RasseExtern : in RassenDatentypen.Rassen_Enum)
     with
       Pre => (
               (if EigeneRasseExtern /= EinheitenKonstanten.LeerRasse then SpielVariablen.RassenImSpiel (EigeneRasseExtern) = RassenDatentypen.Mensch_Spieler_Enum)
               and
                 (if RasseExtern /= EinheitenKonstanten.LeerRasse then SpielVariablen.RassenImSpiel (RasseExtern) /= RassenDatentypen.Leer_Spieler_Enum)
              );
   
   procedure FarbenFluss
     (GrundExtern : in KartengrundDatentypen.Kartengrund_Vorhanden_Enum;
      FlussExtern : in KartengrundDatentypen.Kartenfluss_Vorhanden_Enum);
   
   procedure FarbenRessourcen
     (GrundExtern : in KartengrundDatentypen.Kartengrund_Vorhanden_Enum;
      RessourceExtern : in KartengrundDatentypen.Kartenressourcen_Vorhanden_Enum);
   
   procedure FarbenFeld
     (GrundExtern : in KartengrundDatentypen.Kartengrund_Vorhanden_Enum);

end FarbgebungTerminal;

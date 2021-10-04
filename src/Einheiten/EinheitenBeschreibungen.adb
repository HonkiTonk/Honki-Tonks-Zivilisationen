pragma SPARK_Mode (On);

with GlobaleTexte, SystemKonstanten, EinheitenKonstanten;

with Anzeige, Auswahl;

package body EinheitenBeschreibungen is

   procedure BeschreibungKurz
     (IDExtern : in EinheitStadtDatentypen.EinheitenIDMitNullWert)
   is begin
      
      case
        IDExtern
      is
         when EinheitStadtDatentypen.EinheitenIDMitNullWert'First =>
            return;
            
         when others =>
            null;
      end case;
      
      Anzeige.AnzeigeOhneAuswahlNeu (ÜberschriftDateiExtern => GlobaleTexte.Leer,
                                     TextDateiExtern        => GlobaleTexte.Beschreibungen_Einheiten_Kurz,
                                     ÜberschriftZeileExtern => 0,
                                     ErsteZeileExtern       => Positive (IDExtern),
                                     LetzteZeileExtern      => Positive (IDExtern),
                                     AbstandAnfangExtern    => GlobaleTexte.Leer,
                                     AbstandMitteExtern     => GlobaleTexte.Leer,
                                     AbstandEndeExtern      => GlobaleTexte.Leer);
      
   end BeschreibungKurz;
   
   
   
   procedure BeschreibungLang
     (IDExtern : in EinheitStadtDatentypen.EinheitenIDMitNullWert)
   is begin
      
      case
        IDExtern
      is
         when EinheitStadtDatentypen.EinheitenIDMitNullWert'First =>
            return;
            
         when others =>
            null;
      end case;
      
      Anzeige.AnzeigeLangerTextNeu (ÜberschriftDateiExtern => GlobaleTexte.Leer,
                                    TextDateiExtern        => GlobaleTexte.Beschreibungen_Einheiten_Lang,
                                    ÜberschriftZeileExtern => 0,
                                    ErsteZeileExtern       => Positive (IDExtern),
                                    AbstandAnfangExtern    => GlobaleTexte.Neue_Zeile,
                                    AbstandEndeExtern      => GlobaleTexte.Leer);
      
   end BeschreibungLang;
   
   
   
   procedure Beschäftigung
     (ArbeitExtern : in GlobaleDatentypen.Tastenbelegung_Enum)
   is begin
      
      case
        ArbeitExtern
      is
         when GlobaleDatentypen.Leer =>
            Anzeige.AnzeigeOhneAuswahlNeu (ÜberschriftDateiExtern => GlobaleTexte.Leer,
                                           TextDateiExtern        => GlobaleTexte.Beschreibungen_Beschäftigung_Kurz,
                                           ÜberschriftZeileExtern => 0,
                                           ErsteZeileExtern       => 9,
                                           LetzteZeileExtern      => 9,
                                           AbstandAnfangExtern    => GlobaleTexte.Leer,
                                           AbstandMitteExtern     => GlobaleTexte.Leer,
                                           AbstandEndeExtern      => GlobaleTexte.Leer);
            
         when others =>
            Anzeige.AnzeigeOhneAuswahlNeu (ÜberschriftDateiExtern => GlobaleTexte.Leer,
                                           TextDateiExtern        => GlobaleTexte.Beschreibungen_Beschäftigung_Kurz,
                                           ÜberschriftZeileExtern => 0,
                                           -- Der Abzug wird für die Textanzeige benötigt
                                           ErsteZeileExtern       => GlobaleDatentypen.Tastenbelegung_Befehle_Enum'Pos (ArbeitExtern) - EinheitenKonstanten.EinheitBefehlAbzug,
                                           LetzteZeileExtern      => GlobaleDatentypen.Tastenbelegung_Befehle_Enum'Pos (ArbeitExtern) - EinheitenKonstanten.EinheitBefehlAbzug,
                                           AbstandAnfangExtern    => GlobaleTexte.Leer,
                                           AbstandMitteExtern     => GlobaleTexte.Leer,
                                           AbstandEndeExtern      => GlobaleTexte.Leer);
      end case;
      
   end Beschäftigung;
   


   function BeschäftigungAbbrechenVerbesserungErsetzenBrandschatzenEinheitAuflösen
     (WelcheAuswahlExtern : in Natural)
      return Boolean
   is begin
      
      case
        Auswahl.AuswahlJaNein (FrageZeileExtern => WelcheAuswahlExtern)
      is
         when SystemKonstanten.JaKonstante =>
            return True;
            
         when others =>
            return False;
      end case;
      
   end BeschäftigungAbbrechenVerbesserungErsetzenBrandschatzenEinheitAuflösen;

end EinheitenBeschreibungen;

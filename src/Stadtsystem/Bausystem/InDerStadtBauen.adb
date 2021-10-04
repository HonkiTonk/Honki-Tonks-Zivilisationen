pragma SPARK_Mode (On);

with Ada.Wide_Wide_Text_IO, Ada.Strings.Wide_Wide_Unbounded, Ada.Characters.Wide_Wide_Latin_9;
use Ada.Wide_Wide_Text_IO, Ada.Strings.Wide_Wide_Unbounded, Ada.Characters.Wide_Wide_Latin_9;

with SystemKonstanten, GlobaleTexte, EinheitenKonstanten, StadtKonstanten;

with SchreibeStadtGebaut;
with LeseStadtGebaut;
     
with Anzeige, Eingabe, Auswahl, GebaeudeAllgemein, EinheitenModifizieren, EinheitBauen, GebaeudeBauen;

package body InDerStadtBauen is

   procedure Bauen
     (StadtRasseNummerExtern : in EinheitStadtRecords.RassePlatznummerRecord)
   is begin
      
      case
        LeseStadtGebaut.Bauprojekt (StadtRasseNummerExtern => StadtRasseNummerExtern)
      is
         when StadtKonstanten.LeerBauprojekt =>
            null;
            
         when others =>
            if
              Auswahl.AuswahlJaNein (FrageZeileExtern => 14) = SystemKonstanten.JaKonstante
            then
               null;
               
            else
               return;
            end if;
      end case;
      
      SchreibeStadtGebaut.Ressourcen (StadtRasseNummerExtern => StadtRasseNummerExtern,
                                      RessourcenExtern       => StadtKonstanten.LeerStadt.Ressourcen,
                                      ÄndernSetzenExtern    => False);
      SchreibeStadtGebaut.Bauprojekt (StadtRasseNummerExtern => StadtRasseNummerExtern,
                                      BauprojektExtern       => BauobjektAuswählen (StadtRasseNummerExtern => StadtRasseNummerExtern));
      
   end Bauen;



   function BauobjektAuswählen
     (StadtRasseNummerExtern : in EinheitStadtRecords.RassePlatznummerRecord)
      return Natural
   is begin

      Ende := 1;
      Anzeige.AllgemeineAnzeigeText := (others => (To_Unbounded_Wide_Wide_String (Source => SystemKonstanten.LeerText), 0));

      MöglicheGebäudeErmitteln (StadtRasseNummerExtern => StadtRasseNummerExtern);
      MöglicheEinheitenErmitteln (StadtRasseNummerExtern => StadtRasseNummerExtern);

      if
        Anzeige.AllgemeineAnzeigeText (Ende).Nummer = 0
        and
          Ende > 1
      then
         Anzeige.AllgemeineAnzeigeText (Ende).Text := GlobaleTexte.TexteEinlesenNeu (GlobaleTexte.Welche_Datei_Enum'Pos (GlobaleTexte.Feste_Abfragen), 3);

      elsif
        Anzeige.AllgemeineAnzeigeText (Ende).Nummer = 0
        and
          Ende = 1
      then
         return 0;
         
      else
         Ende := Ende + 1;
         Anzeige.AllgemeineAnzeigeText (Ende).Text := GlobaleTexte.TexteEinlesenNeu (GlobaleTexte.Welche_Datei_Enum'Pos (GlobaleTexte.Feste_Abfragen), 3);
      end if;

      return AuswahlBauprojekt (StadtRasseNummerExtern => StadtRasseNummerExtern);
      
   end BauobjektAuswählen;
   
   
   
   procedure MöglicheGebäudeErmitteln
     (StadtRasseNummerExtern : in EinheitStadtRecords.RassePlatznummerRecord)
   is begin
      
      GebäudeSchleife:
      for GebäudeSchleifenwert in EinheitStadtDatentypen.GebäudeID'Range loop
         
         if
           To_Wide_Wide_String (Source => GlobaleTexte.TexteEinlesenNeu (GlobaleTexte.Welche_Datei_Enum'Pos (GlobaleTexte.Beschreibungen_Gebäude_Kurz),
                                Positive (GebäudeSchleifenwert)))
           = SystemKonstanten.LeerText
         then
            exit GebäudeSchleife;
            
         else
            null;
         end if;
         
         if
           GebaeudeAllgemein.GebäudeAnforderungenErfüllt (StadtRasseNummerExtern => StadtRasseNummerExtern,
                                                            IDExtern               => GebäudeSchleifenwert)
           = True
         then
            Anzeige.AllgemeineAnzeigeText (Ende).Text
              := GlobaleTexte.TexteEinlesenNeu (GlobaleTexte.Welche_Datei_Enum'Pos (GlobaleTexte.Beschreibungen_Gebäude_Kurz), Positive (GebäudeSchleifenwert));
            Anzeige.AllgemeineAnzeigeText (Ende).Nummer := StadtKonstanten.GebäudeAufschlag + Positive (GebäudeSchleifenwert);
            Ende := Ende + 1;
            
         else
            null;
         end if;
         
      end loop GebäudeSchleife;
      
   end MöglicheGebäudeErmitteln;
   
   
   
   procedure MöglicheEinheitenErmitteln
     (StadtRasseNummerExtern : in EinheitStadtRecords.RassePlatznummerRecord)
   is begin
      
      EinheitenSchleife:
      for EinheitSchleifenwert in EinheitStadtDatentypen.EinheitenID'Range loop
         
         if
           To_Wide_Wide_String (Source => GlobaleTexte.TexteEinlesenNeu (GlobaleTexte.Welche_Datei_Enum'Pos (GlobaleTexte.Beschreibungen_Einheiten_Kurz),
                                Positive (EinheitSchleifenwert)))
           = SystemKonstanten.LeerText
         then
            exit EinheitenSchleife;
            
         else
            null;
         end if;
         
         if
           EinheitenModifizieren.EinheitAnforderungenErfüllt (StadtRasseNummerExtern => StadtRasseNummerExtern,
                                                               IDExtern               => EinheitSchleifenwert)
           = True
         then
            Anzeige.AllgemeineAnzeigeText (Ende).Text
              := GlobaleTexte.TexteEinlesenNeu (GlobaleTexte.Welche_Datei_Enum'Pos (GlobaleTexte.Beschreibungen_Einheiten_Kurz),
                                                Positive (EinheitSchleifenwert));
            Anzeige.AllgemeineAnzeigeText (Ende).Nummer := EinheitenKonstanten.EinheitAufschlag + Positive (EinheitSchleifenwert);
            Ende := Ende + 1;
            
         else
            null;
         end if;
         
      end loop EinheitenSchleife;
      
   end MöglicheEinheitenErmitteln;
   
   
   
   function AuswahlBauprojekt
     (StadtRasseNummerExtern : in EinheitStadtRecords.RassePlatznummerRecord)
      return Natural
   is begin
      
      Anzeige.AktuelleAuswahl := 1;

      AuswahlSchleife:
      loop

         Put (Item => CSI & "2J" & CSI & "3J"  & CSI & "H");

         Anzeige.EinzeiligeAnzeigeOhneAuswahl (TextDateiExtern => GlobaleTexte.Fragen,
                                               TextZeileExtern => 13);

         Anzeige.AllgemeineAnzeige (AktuelleAuswahlExtern => Anzeige.AktuelleAuswahl);
         
         if
           Anzeige.AktuelleAuswahl = Ende
         then
            null;
                  
         elsif
           Anzeige.AllgemeineAnzeigeText (Anzeige.AktuelleAuswahl).Nummer > EinheitenKonstanten.EinheitAufschlag
         then
            EinheitBauen.AnzeigeEinheiten (StadtRasseNummerExtern => StadtRasseNummerExtern);
            
         else
            GebaeudeBauen.AnzeigeGebäude (StadtRasseNummerExtern => StadtRasseNummerExtern);
         end if;
         
         case
           Eingabe.Tastenwert
         is
            when GlobaleDatentypen.Hoch =>
               if
                 Anzeige.AktuelleAuswahl = Anzeige.AllgemeineAnzeigeText'First
               then
                  Anzeige.AktuelleAuswahl := Ende;
                  
               else
                  Anzeige.AktuelleAuswahl := Anzeige.AktuelleAuswahl - 1;
               end if;

            when GlobaleDatentypen.Runter =>
               if
                 Anzeige.AktuelleAuswahl = Ende
               then
                  Anzeige.AktuelleAuswahl := Anzeige.AllgemeineAnzeigeText'First;
                  
               else
                  Anzeige.AktuelleAuswahl := Anzeige.AktuelleAuswahl + 1;
               end if;
                              
            when GlobaleDatentypen.Auswählen =>
               return Anzeige.AllgemeineAnzeigeText (Anzeige.AktuelleAuswahl).Nummer;

            when GlobaleDatentypen.Menü_Zurück =>
               return 0;
                     
            when others =>
               null;
         end case;
         
      end loop AuswahlSchleife;
      
   end AuswahlBauprojekt;

end InDerStadtBauen;

pragma SPARK_Mode (On);

with Ada.Wide_Wide_Text_IO; use Ada.Wide_Wide_Text_IO;
with Ada.Strings.Wide_Wide_Unbounded; use Ada.Strings.Wide_Wide_Unbounded;
with Ada.Characters.Wide_Wide_Latin_1; use Ada.Characters.Wide_Wide_Latin_1;

with EinheitStadtDatentypen; use EinheitStadtDatentypen;
with SystemKonstanten;
with GlobaleTexte;
with EinheitenKonstanten;
with StadtKonstanten;

with SchreibeStadtGebaut;
with LeseStadtGebaut;
     
with Anzeige;
with Eingabe;
with Auswahl;
with GebaeudeAllgemein;
with EinheitenModifizieren;
with EinheitBauen;
with GebaeudeBauen;

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
      Anzeige.AllgemeineAnzeigeText := (others => (SystemKonstanten.LeerUnboundedString, 0));

      MöglicheGebäudeErmitteln (StadtRasseNummerExtern => StadtRasseNummerExtern);
      MöglicheEinheitenErmitteln (StadtRasseNummerExtern => StadtRasseNummerExtern);

      if
        Anzeige.AllgemeineAnzeigeText (Ende).Nummer = 0
        and
          Ende > 1
      then
         Anzeige.AllgemeineAnzeigeText (Ende).Text := GlobaleTexte.TexteEinlesen (GlobaleTexte.Welche_Datei_Enum'Pos (GlobaleTexte.Feste_Abfragen), 3);

      elsif
        Anzeige.AllgemeineAnzeigeText (Ende).Nummer = 0
        and
          Ende = 1
      then
         return 0;
         
      else
         Ende := Ende + 1;
         Anzeige.AllgemeineAnzeigeText (Ende).Text := GlobaleTexte.TexteEinlesen (GlobaleTexte.Welche_Datei_Enum'Pos (GlobaleTexte.Feste_Abfragen), 3);
      end if;

      return AuswahlBauprojekt (StadtRasseNummerExtern => StadtRasseNummerExtern);
      
   end BauobjektAuswählen;
   
   
   
   procedure MöglicheGebäudeErmitteln
     (StadtRasseNummerExtern : in EinheitStadtRecords.RassePlatznummerRecord)
   is begin
      
      GebäudeSchleife:
      for GebäudeSchleifenwert in EinheitStadtDatentypen.GebäudeID'Range loop
         
         if
           GlobaleTexte.TexteEinlesen (GlobaleTexte.Welche_Datei_Enum'Pos (GlobaleTexte.Beschreibungen_Gebäude_Kurz), Positive (GebäudeSchleifenwert)) = SystemKonstanten.LeerUnboundedString
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
              := GlobaleTexte.TexteEinlesen (GlobaleTexte.Welche_Datei_Enum'Pos (GlobaleTexte.Beschreibungen_Gebäude_Kurz), Positive (GebäudeSchleifenwert));
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
           GlobaleTexte.TexteEinlesen (GlobaleTexte.Welche_Datei_Enum'Pos (GlobaleTexte.Beschreibungen_Einheiten_Kurz), Positive (EinheitSchleifenwert)) = SystemKonstanten.LeerUnboundedString
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
              := GlobaleTexte.TexteEinlesen (GlobaleTexte.Welche_Datei_Enum'Pos (GlobaleTexte.Beschreibungen_Einheiten_Kurz),
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
            when SystemDatentypen.Oben =>
               if
                 Anzeige.AktuelleAuswahl = Anzeige.AllgemeineAnzeigeText'First
               then
                  Anzeige.AktuelleAuswahl := Ende;
                  
               else
                  Anzeige.AktuelleAuswahl := Anzeige.AktuelleAuswahl - 1;
               end if;

            when SystemDatentypen.Unten =>
               if
                 Anzeige.AktuelleAuswahl = Ende
               then
                  Anzeige.AktuelleAuswahl := Anzeige.AllgemeineAnzeigeText'First;
                  
               else
                  Anzeige.AktuelleAuswahl := Anzeige.AktuelleAuswahl + 1;
               end if;
                              
            when SystemDatentypen.Auswählen =>
               return Anzeige.AllgemeineAnzeigeText (Anzeige.AktuelleAuswahl).Nummer;

            when SystemDatentypen.Menü_Zurück =>
               return 0;
                     
            when others =>
               null;
         end case;
         
      end loop AuswahlSchleife;
      
   end AuswahlBauprojekt;

end InDerStadtBauen;

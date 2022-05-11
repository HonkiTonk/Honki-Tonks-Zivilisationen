pragma SPARK_Mode (On);
pragma Warnings (Off, "*array aggregate*");

with Ada.Wide_Wide_Text_IO; use Ada.Wide_Wide_Text_IO;
with Ada.Characters.Wide_Wide_Latin_1; use Ada.Characters.Wide_Wide_Latin_1;

with EinheitenDatentypen; use EinheitenDatentypen;
with EinheitenKonstanten;

with LeseEinheitenDatenbank;
with LeseEinheitenGebaut;

-------------------------- Wird für die Konsole benötigt, muss aber noch in Logik und Grafik aufgeteilt werden.
package body EinheitenTransporter is

   function EinheitTransporterAuswählen
     (EinheitRasseNummerExtern : in EinheitenRecords.RasseEinheitnummerRecord)
      return EinheitenDatentypen.MaximaleEinheitenMitNullWert
   is begin

      ------------------------------- Mal in Logik und Grafik und Konsole und SFML aufteilen.
      -- TextAnzeigeKonsole.AllgemeineAnzeigeText := (others => (TextKonstanten.LeerUnboundedString, 0));
      -- TextAnzeigeKonsole.AllgemeineAnzeigeText (1) := (GlobaleTexte.TexteEinlesen (GlobaleTexte.Welche_Datei_Enum'Pos (GlobaleTexte.Beschreibungen_Einheiten_Kurz),
      --                                                 Positive (LeseEinheitenGebaut.ID (EinheitRasseNummerExtern => EinheitRasseNummerExtern))), Positive (EinheitRasseNummerExtern.Platznummer));
      AktuellePosition := 2;
      Ende := 1;

      TransporterSchleife:
      for TransporterPlatzSchleifenwert in EinheitenRecords.TransporterArray'First .. LeseEinheitenDatenbank.Transportkapazität (RasseExtern => EinheitRasseNummerExtern.Rasse,
                                                                                                                                     IDExtern    =>
                                                                                                                                       LeseEinheitenGebaut.ID (EinheitRasseNummerExtern => EinheitRasseNummerExtern)) loop
         
         Transportiert := LeseEinheitenGebaut.Transportiert (EinheitRasseNummerExtern => EinheitRasseNummerExtern,
                                                             PlatzExtern              => TransporterPlatzSchleifenwert);
         
         if
           Transportiert = EinheitenKonstanten.LeerTransportiert
         then
            null;
            
         else
            -- TextAnzeigeKonsole.AllgemeineAnzeigeText (AktuellePosition)
            --  := (GlobaleTexte.TexteEinlesen (GlobaleTexte.Welche_Datei_Enum'Pos (GlobaleTexte.Beschreibungen_Einheiten_Kurz),                  
            --      Positive (LeseEinheitenGebaut.ID (EinheitRasseNummerExtern => (EinheitRasseNummerExtern.Rasse, Transportiert)))),
            --      Positive (Transportiert));

            AktuellePosition := AktuellePosition + 1;
            Ende := Ende + 1;
         end if;
         
      end loop TransporterSchleife;

      return EinheitAuswählen;
      
   end EinheitTransporterAuswählen;
   
   
   
   function EinheitAuswählen
     return EinheitenDatentypen.MaximaleEinheitenMitNullWert
   is begin
      
      AktuelleAuswahl := 1;
      
      EinheitAuswählenSchleife:
      loop
         
         Put (Item => CSI & "2J" & CSI & "3J"  & CSI & "H");

         -- TextAnzeigeKonsole.EinzeiligeAnzeigeOhneAuswahl (TextDateiExtern => GlobaleTexte.Fragen,
         --                                                 TextZeileExtern => 27);
         -- TextAnzeigeKonsole.AllgemeineAnzeige (AktuelleAuswahlExtern => EinheitenDatentypen.EinheitenIDMitNullWert (AktuelleAuswahl));
                  
       --  case
       --    Eingabe.Tastenwert
       --  is               
       --     when TastenbelegungDatentypen.Oben_Enum =>
       --        if
       --          AktuelleAuswahl = TextAnzeigeKonsole.AllgemeineAnzeigeText'First
       --        then
       --           AktuelleAuswahl := Ende;
       --        else
       --           AktuelleAuswahl := AktuelleAuswahl - 1;
       --        end if;

       --     when TastenbelegungDatentypen.Unten_Enum =>
      --         if
       --          AktuelleAuswahl = Ende
      --         then
      --            AktuelleAuswahl := TextAnzeigeKonsole.AllgemeineAnzeigeText'First;
      --         else
      --            AktuelleAuswahl := AktuelleAuswahl + 1;
      --         end if;
                              
      --      when TastenbelegungDatentypen.Auswählen_Enum =>
      --         return EinheitenDatentypen.MaximaleEinheitenMitNullWert (TextAnzeigeKonsole.AllgemeineAnzeigeText (AktuelleAuswahl).Nummer);

       --     when TastenbelegungDatentypen.Menü_Zurück_Enum =>
               return 0;
                     
      --      when others =>
      --         null;
      --   end case;
         
      end loop EinheitAuswählenSchleife;
      
   end EinheitAuswählen;
   
   
   
   function KannTransportiertWerden
     (LadungExtern : in EinheitenRecords.RasseEinheitnummerRecord;
      TransporterExtern : in EinheitenRecords.RasseEinheitnummerRecord)
      return Boolean
   is begin
      
      case
        LeseEinheitenGebaut.ID (EinheitRasseNummerExtern => (TransporterExtern.Rasse, TransporterExtern.Nummer))
      is
         when EinheitenKonstanten.LeerID =>
            return False;
            
         when others =>
            null;
      end case;
      
      if
        LeseEinheitenDatenbank.KannTransportiertWerden (RasseExtern => LadungExtern.Rasse,
                                                        IDExtern    => LeseEinheitenGebaut.ID (EinheitRasseNummerExtern => (LadungExtern.Rasse, LadungExtern.Nummer)))
        = EinheitenKonstanten.LeerKannTransportiertWerden
        or
          LeseEinheitenDatenbank.KannTransportieren (RasseExtern => TransporterExtern.Rasse,
                                                     IDExtern    => LeseEinheitenGebaut.ID (EinheitRasseNummerExtern => (TransporterExtern.Rasse, TransporterExtern.Nummer)))
        <
        LeseEinheitenDatenbank.KannTransportiertWerden (RasseExtern => LadungExtern.Rasse,
                                                        IDExtern    => LeseEinheitenGebaut.ID (EinheitRasseNummerExtern => (LadungExtern.Rasse, LadungExtern.Nummer)))
      then
         return False;
         
      else
         null;
      end if;
      
      return PlatzFrei (TransporterExtern => TransporterExtern);
      
   end KannTransportiertWerden;
   
   
   
   function PlatzFrei
     (TransporterExtern : in EinheitenRecords.RasseEinheitnummerRecord)
      return Boolean
   is begin
      
      PlatzFreiSchleife:
      for PlatzSchleifenwert in EinheitenRecords.TransporterArray'First .. LeseEinheitenDatenbank.Transportkapazität (RasseExtern => TransporterExtern.Rasse,
                                                                                                                          IDExtern    => LeseEinheitenGebaut.ID (EinheitRasseNummerExtern => TransporterExtern)) loop
         
         if
           LeseEinheitenGebaut.Transportiert (EinheitRasseNummerExtern => (TransporterExtern.Rasse, TransporterExtern.Nummer),
                                              PlatzExtern              => PlatzSchleifenwert)
           = EinheitenKonstanten.LeerTransportiert
         then
            return True;
            
         else
            null;
         end if;
         
      end loop PlatzFreiSchleife;
      
      return False;
      
   end PlatzFrei;

end EinheitenTransporter;

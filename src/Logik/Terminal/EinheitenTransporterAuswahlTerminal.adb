pragma SPARK_Mode (On);
pragma Warnings (Off, "*array aggregate*");

with EinheitenDatentypen; use EinheitenDatentypen;
with EinheitenKonstanten;

with LeseEinheitenDatenbank;
with LeseEinheitenGebaut;

package body EinheitenTransporterAuswahlTerminal is

   function EinheitTransporterAuswählen
     (EinheitRasseNummerExtern : in EinheitenRecords.RasseEinheitnummerRecord)
      return EinheitenDatentypen.MaximaleEinheitenMitNullWert
   is begin

      -- TextAnzeigeTerminal.AllgemeineAnzeigeText := (others => (TextKonstanten.LeerUnboundedString, 0));
      -- TextAnzeigeTerminal.AllgemeineAnzeigeText (1) := (GlobaleTexte.TexteEinlesen (GlobaleTexte.Welche_Datei_Enum'Pos (GlobaleTexte.Beschreibungen_Einheiten_Kurz),
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
            -- TextAnzeigeTerminal.AllgemeineAnzeigeText (AktuellePosition)
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
         
         -- Put (Item => CSI & "2J" & CSI & "3J"  & CSI & "H");

         -- TextAnzeigeTerminal.EinzeiligeAnzeigeOhneAuswahl (TextDateiExtern => GlobaleTexte.Fragen,
         --                                                 TextZeileExtern => 27);
         -- TextAnzeigeTerminal.AllgemeineAnzeige (AktuelleAuswahlExtern => EinheitenDatentypen.EinheitenIDMitNullWert (AktuelleAuswahl));
                  
         --  case
         --    Eingabe.Tastenwert
         --  is               
         --     when TastenbelegungDatentypen.Oben_Enum =>
         --        if
         --          AktuelleAuswahl = TextAnzeigeTerminal.AllgemeineAnzeigeText'First
         --        then
         --           AktuelleAuswahl := Ende;
         --        else
         --           AktuelleAuswahl := AktuelleAuswahl - 1;
         --        end if;

         --     when TastenbelegungDatentypen.Unten_Enum =>
         --         if
         --          AktuelleAuswahl = Ende
         --         then
         --            AktuelleAuswahl := TextAnzeigeTerminal.AllgemeineAnzeigeText'First;
         --         else
         --            AktuelleAuswahl := AktuelleAuswahl + 1;
         --         end if;
                              
         --      when TastenbelegungDatentypen.Auswählen_Enum =>
         --         return EinheitenDatentypen.MaximaleEinheitenMitNullWert (TextAnzeigeTerminal.AllgemeineAnzeigeText (AktuelleAuswahl).Nummer);

         --     when TastenbelegungDatentypen.Menü_Zurück_Enum =>
         return 0;
                     
         --      when others =>
         --         null;
         --   end case;
         
      end loop EinheitAuswählenSchleife;
      
   end EinheitAuswählen;

end EinheitenTransporterAuswahlTerminal;

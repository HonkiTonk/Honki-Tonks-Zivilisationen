pragma SPARK_Mode (On);

with Ada.Wide_Wide_Text_IO; use Ada.Wide_Wide_Text_IO;
with Ada.Characters.Wide_Wide_Latin_9; use Ada.Characters.Wide_Wide_Latin_9;
with Ada.Strings.Wide_Wide_Unbounded; use Ada.Strings.Wide_Wide_Unbounded;

with EinheitStadtDatentypen; use EinheitStadtDatentypen;
with GlobaleTexte;
with SystemKonstanten;
with EinheitenKonstanten;
with SystemDatentypen;

with LeseEinheitenDatenbank;
with LeseEinheitenGebaut;

with Anzeige;
with Eingabe;

package body EinheitenTransporter is

   function EinheitTransporterAuswählen
     (EinheitRasseNummerExtern : in EinheitStadtRecords.RassePlatznummerRecord)
      return EinheitStadtDatentypen.MaximaleEinheitenMitNullWert
   is begin

      Anzeige.AllgemeineAnzeigeText := (others => (To_Unbounded_Wide_Wide_String (Source => SystemKonstanten.LeerText), 0));
      Anzeige.AllgemeineAnzeigeText (1) := (GlobaleTexte.TexteEinlesenNeu (GlobaleTexte.Welche_Datei_Enum'Pos (GlobaleTexte.Beschreibungen_Einheiten_Kurz),
                                            Positive (LeseEinheitenGebaut.ID (EinheitRasseNummerExtern => EinheitRasseNummerExtern))), Positive (EinheitRasseNummerExtern.Platznummer));
      AktuellePosition := 2;
      Ende := 1;

      TransporterSchleife:
      for TransporterPlatzSchleifenwert in EinheitStadtRecords.TransporterArray'First .. LeseEinheitenDatenbank.Transportkapazität (RasseExtern => EinheitRasseNummerExtern.Rasse,
                                                                                                                                     IDExtern    =>
                                                                                                                                       LeseEinheitenGebaut.ID (EinheitRasseNummerExtern => EinheitRasseNummerExtern)) loop
         
         Transportiert := LeseEinheitenGebaut.Transportiert (EinheitRasseNummerExtern => EinheitRasseNummerExtern,
                                                             PlatzExtern              => TransporterPlatzSchleifenwert);
         
         if
           Transportiert = EinheitenKonstanten.LeerTransportiert
         then
            null;
            
         else
            Anzeige.AllgemeineAnzeigeText (AktuellePosition)
              := (GlobaleTexte.TexteEinlesenNeu (GlobaleTexte.Welche_Datei_Enum'Pos (GlobaleTexte.Beschreibungen_Einheiten_Kurz),                  
                  Positive (LeseEinheitenGebaut.ID (EinheitRasseNummerExtern => (EinheitRasseNummerExtern.Rasse, Transportiert)))),
                  Positive (Transportiert));

            AktuellePosition := AktuellePosition + 1;
            Ende := Ende + 1;
         end if;
         
      end loop TransporterSchleife;

      return EinheitAuswählen;
      
   end EinheitTransporterAuswählen;
   
   
   
   function EinheitAuswählen
     return EinheitStadtDatentypen.MaximaleEinheitenMitNullWert
   is begin
      
      AktuelleAuswahl := 1;
      
      EinheitAuswählenSchleife:
      loop
         
         Put (Item => CSI & "2J" & CSI & "3J"  & CSI & "H");

         Anzeige.EinzeiligeAnzeigeOhneAuswahl (TextDateiExtern => GlobaleTexte.Fragen,
                                               TextZeileExtern => 27);
         Anzeige.AllgemeineAnzeige (AktuelleAuswahlExtern => EinheitStadtDatentypen.MinimimMaximumID (AktuelleAuswahl));
                  
         case
           Eingabe.Tastenwert
         is               
            when SystemDatentypen.Hoch =>
               if
                 AktuelleAuswahl = Anzeige.AllgemeineAnzeigeText'First
               then
                  AktuelleAuswahl := Ende;
               else
                  AktuelleAuswahl := AktuelleAuswahl - 1;
               end if;

            when SystemDatentypen.Runter =>
               if
                 AktuelleAuswahl = Ende
               then
                  AktuelleAuswahl := Anzeige.AllgemeineAnzeigeText'First;
               else
                  AktuelleAuswahl := AktuelleAuswahl + 1;
               end if;
                              
            when SystemDatentypen.Auswählen =>
               return EinheitStadtDatentypen.MaximaleEinheitenMitNullWert (Anzeige.AllgemeineAnzeigeText (AktuelleAuswahl).Nummer);

            when SystemDatentypen.Menü_Zurück =>
               return 0;
                     
            when others =>
               null;
         end case;
         
      end loop EinheitAuswählenSchleife;
      
   end EinheitAuswählen;
   
   
   
   function KannTransportiertWerden
     (LadungExtern : in EinheitStadtRecords.RassePlatznummerRecord;
      TransporterExtern : in EinheitStadtRecords.RassePlatznummerRecord)
      return Boolean
   is begin
      
      case
        LeseEinheitenGebaut.ID (EinheitRasseNummerExtern => (TransporterExtern.Rasse, TransporterExtern.Platznummer))
      is
         when EinheitenKonstanten.LeerID =>
            return False;
            
         when others =>
            null;
      end case;
      
      if
        LeseEinheitenDatenbank.KannTransportiertWerden (RasseExtern => LadungExtern.Rasse,
                                                        IDExtern    => LeseEinheitenGebaut.ID (EinheitRasseNummerExtern => (LadungExtern.Rasse, LadungExtern.Platznummer)))
        = EinheitenKonstanten.LeerKannTransportiertWerden
        or
          LeseEinheitenDatenbank.KannTransportieren (RasseExtern => TransporterExtern.Rasse,
                                                     IDExtern    => LeseEinheitenGebaut.ID (EinheitRasseNummerExtern => (TransporterExtern.Rasse, TransporterExtern.Platznummer)))
        <
        LeseEinheitenDatenbank.KannTransportiertWerden (RasseExtern => LadungExtern.Rasse,
                                                        IDExtern    => LeseEinheitenGebaut.ID (EinheitRasseNummerExtern => (LadungExtern.Rasse, LadungExtern.Platznummer)))
      then
         return False;
         
      else
         null;
      end if;
      
      return PlatzFrei (TransporterExtern => TransporterExtern);
      
   end KannTransportiertWerden;
   
   
   
   function PlatzFrei
     (TransporterExtern : in EinheitStadtRecords.RassePlatznummerRecord)
      return Boolean
   is begin
      
      PlatzFreiSchleife:
      for PlatzSchleifenwert in EinheitStadtRecords.TransporterArray'First .. LeseEinheitenDatenbank.Transportkapazität (RasseExtern => TransporterExtern.Rasse,
                                                                                                                          IDExtern    => LeseEinheitenGebaut.ID (EinheitRasseNummerExtern => TransporterExtern)) loop
         
         if
           LeseEinheitenGebaut.Transportiert (EinheitRasseNummerExtern => (TransporterExtern.Rasse, TransporterExtern.Platznummer),
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
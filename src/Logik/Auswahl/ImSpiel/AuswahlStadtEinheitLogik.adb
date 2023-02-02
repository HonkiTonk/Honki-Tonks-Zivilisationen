with TastenbelegungDatentypen;
with GrafikDatentypen;
with GrafikRecordKonstanten;
with InteraktionAuswahl;

with LeseEinheitenGebaut;

with NachGrafiktask;
with TasteneingabeLogik;
with MausauswahlLogik;

-- Kann man das so umbauen dass es wie die restlichen Mausauswahlen eine 0 als Leerauswahl zurück gibt? äöü
-- Kann man vermutlich aber dazu müsste man wohl mehr anpassen. äöü
package body AuswahlStadtEinheitLogik is

   function AuswahlStadtEinheit
     (SpeziesExtern : in SpeziesDatentypen.Spezies_Verwendet_Enum;
      -- Wenn die StadtNummerExtern = 0 ist, dann wird von einem beladenen Transporter ausgegangen.
      StadtNummerExtern : in StadtDatentypen.MaximaleStädteMitNullWert;
      EinheitNummerExtern : in EinheitenDatentypen.MaximaleEinheiten)
      return Integer
   is begin
      
      WelcheAuswahl.MöglicheAuswahlen := (others => 0);
      
      if
        StadtNummerExtern /= StadtDatentypen.MaximaleStädteMitNullWert'First
      then
         WelcheAuswahl.StadtEinheit := True;
         WelcheAuswahl.MöglicheAuswahlen (0) := EinheitenDatentypen.MaximaleEinheitenMitNullWert (StadtNummerExtern);
         WelcheAuswahl.MöglicheAuswahlen (1) := EinheitNummerExtern;

      else
         WelcheAuswahl.StadtEinheit := False;
         WelcheAuswahl.MöglicheAuswahlen (0) := EinheitNummerExtern;
         
         TransporterSchleife:
         for WirdTransportiertSchleifenwert in EinheitenRecords.TransporterArray'Range loop
            
            WelcheAuswahl.MöglicheAuswahlen (WirdTransportiertSchleifenwert) := LeseEinheitenGebaut.Transportiert (EinheitSpeziesNummerExtern => (SpeziesExtern, EinheitNummerExtern),
                                                                                                                    PlatzExtern                => WirdTransportiertSchleifenwert);
            
         end loop TransporterSchleife;
      end if;
      
      InteraktionAuswahl.PositionenEinheitStadt := (others => GrafikRecordKonstanten.Leerbereich);
      -- Ist da wegen dem Fehler in gnatwu, wenn ich das entferne dann behauptet der Kompiler dass InteraktionAuswahl nicht aufgerufen wird.
      -- Sollte dieser Fehler irgendwann einmal behoben werden, dann kann das weg. äöü
      InteraktionAuswahl.PositionenEinheitStadt (1) := InteraktionAuswahl.PositionenEinheitStadt (2);
      AktuelleAuswahl := 0;
      NachGrafiktask.AktuelleAuswahl.AuswahlEins := AktuelleAuswahl;
      NachGrafiktask.WelcheAuswahl := WelcheAuswahl;
      
      NachGrafiktask.Eingabe := GrafikDatentypen.Einheit_Auswahl_Enum;
      NachGrafiktask.AktuelleStadt := StadtNummerExtern;
      
      AuswahlSchleife:
      loop
         
         AktuelleAuswahl := MausauswahlLogik.StadtEinheitauswahl (AnfangExtern => WelcheAuswahl.MöglicheAuswahlen'First,
                                                                  EndeExtern   => WelcheAuswahl.MöglicheAuswahlen'Last);
         NachGrafiktask.AktuelleAuswahl.AuswahlEins := AktuelleAuswahl;
         
         case
           TasteneingabeLogik.VereinfachteEingabe
         is               
            when TastenbelegungDatentypen.Auswählen_Enum =>
               if
                 AktuelleAuswahl >= 0
               then
                  exit AuswahlSchleife;
                  
               else
                  null;
               end if;
               
            when TastenbelegungDatentypen.Abwählen_Enum =>
               AktuelleAuswahl := -1;
               exit AuswahlSchleife;
               
            when others =>
               null;
         end case;
         
      end loop AuswahlSchleife;
      
      NachGrafiktask.Eingabe := GrafikDatentypen.Keine_Eingabe_Enum;
      
      return AktuelleAuswahl;
      
   end AuswahlStadtEinheit;

end AuswahlStadtEinheitLogik;

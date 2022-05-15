pragma SPARK_Mode (On);
pragma Warnings (Off, "*array aggregate*");

with EinheitenDatentypen; use EinheitenDatentypen;
with TastenbelegungDatentypen;
with SystemDatentypen;

with LeseEinheitenGebaut;

with GrafikEinstellungenSFML;
with InteraktionGrafiktask;
with Eingabe;
with InteraktionAuswahl;

package body AuswahlStadtEinheit is

   function AuswahlStadtEinheit
     (RasseExtern : in RassenDatentypen.Rassen_Verwendet_Enum;
      -- Wenn die StadtNummerExtern = 0 ist, dann wird von einem beladenen Transporter ausgegangen.
      StadtNummerExtern : in StadtDatentypen.MaximaleStädteMitNullWert;
      EinheitNummerExtern : in EinheitenDatentypen.MaximaleEinheitenMitNullWert)
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
            
            WelcheAuswahl.MöglicheAuswahlen (WirdTransportiertSchleifenwert) := LeseEinheitenGebaut.Transportiert (EinheitRasseNummerExtern => (RasseExtern, EinheitNummerExtern),
                                                                                                                    PlatzExtern              => WirdTransportiertSchleifenwert);
              
         end loop TransporterSchleife;
      end if;
      
      AktuelleAuswahl := 0;
      
      InteraktionAuswahl.PositionenEinheitStadt := (others => (0.00, 0.00, 0.00, 0.00));
      InteraktionGrafiktask.EingabeÄndern (EingabeExtern => SystemDatentypen.Einheit_Auswahl_Enum);
      
      AuswahlSchleife:
      loop
         
         AktuelleAuswahl := MausAuswahl;
         
         case
           Eingabe.Tastenwert
         is               
            when TastenbelegungDatentypen.Auswählen_Enum =>
               if
                 AktuelleAuswahl >= 0
               then
                  exit AuswahlSchleife;
                  
               else
                  null;
               end if;
               
            when TastenbelegungDatentypen.Menü_Zurück_Enum =>
               AktuelleAuswahl := -1;
               exit AuswahlSchleife;
               
            when others =>
               null;
         end case;
         
      end loop AuswahlSchleife;
      
      InteraktionGrafiktask.EingabeÄndern (EingabeExtern => SystemDatentypen.Keine_Eingabe_Enum);
      
      return AktuelleAuswahl;
      
   end AuswahlStadtEinheit;
   
   
   
   function MausAuswahl
     return Integer
   is begin
      
      -- Niemals direkt die Mausposition abrufen sondern immer die Werte in der Eingabe ermitteln lassen. Sonst kann es zu einem Absturz kommen.
      MausZeigerPosition := GrafikEinstellungenSFML.MausPosition;
      
      AuswahlSchleife:
      for AuswahlSchleifenwert in WelcheAuswahl.MöglicheAuswahlen'Range loop
         
         if
           MausZeigerPosition.y in Sf.sfInt32 (InteraktionAuswahl.PositionenEinheitStadt (AuswahlSchleifenwert).top)
             .. Sf.sfInt32 (InteraktionAuswahl.PositionenEinheitStadt (AuswahlSchleifenwert).top + InteraktionAuswahl.PositionenEinheitStadt (AuswahlSchleifenwert).height)
             and
               MausZeigerPosition.x in Sf.sfInt32 (InteraktionAuswahl.PositionenEinheitStadt (AuswahlSchleifenwert).left)
                 .. Sf.sfInt32 (InteraktionAuswahl.PositionenEinheitStadt (AuswahlSchleifenwert).left + InteraktionAuswahl.PositionenEinheitStadt (AuswahlSchleifenwert).width)
         then
            return Natural (AuswahlSchleifenwert);
         
         else
            null;
         end if;
         
      end loop AuswahlSchleife;
              
      return -1;
      
   end MausAuswahl;

end AuswahlStadtEinheit;

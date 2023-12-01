with TastenbelegungDatentypen;
with GrafikDatentypen;
with GrafikRecordKonstanten;
with InteraktionAuswahl;
with SystemKonstanten;

with LeseEinheitenGebaut;
with SchreibeGrafiktask;

with TasteneingabeLogik;
with MausauswahlLogik;

-- Kann man das so umbauen dass es wie die restlichen Mausauswahlen eine 0 als Leerauswahl zurück gibt? äöü
-- Kann man vermutlich aber dazu müsste man wohl mehr anpassen. äöü
-- Wäre das überhaupt sinnvoll? äöü
package body AuswahlStadtEinheitLogik is

   function AuswahlStadtEinheit
     (SpeziesExtern : in SpeziesDatentypen.Spezies_Vorhanden_Enum;
      -- Wenn die StadtNummerExtern = 0 ist, dann wird von einem beladenen Transporter ausgegangen.
      StadtnummerExtern : in StadtDatentypen.Städtebereich;
      EinheitNummerExtern : in EinheitenDatentypen.EinheitenbereichVorhanden)
      return Integer
   is begin
      
      WelcheAuswahl.MöglicheAuswahlen := (others => 0);
      
      if
        StadtnummerExtern /= StadtDatentypen.Städtebereich'First
      then
         WelcheAuswahl.StadtEinheit := True;
         WelcheAuswahl.MöglicheAuswahlen (0) := EinheitenDatentypen.Einheitenbereich (StadtnummerExtern);
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
      SchreibeGrafiktask.Erstauswahl (AuswahlExtern => AktuelleAuswahl);
      SchreibeGrafiktask.StadtEinheitAuswahl (AuswahlExtern => WelcheAuswahl);
      
      SchreibeGrafiktask.Eingabeart (EingabeartExtern => GrafikDatentypen.Einheit_Auswahl_Enum);
      SchreibeGrafiktask.Stadtnummer (StadtnummerExtern => StadtnummerExtern);
      
      AuswahlSchleife:
      loop
         
         AktuelleAuswahl := MausauswahlLogik.StadtEinheitauswahl (AnfangExtern => WelcheAuswahl.MöglicheAuswahlen'First,
                                                                  EndeExtern   => WelcheAuswahl.MöglicheAuswahlen'Last);
         SchreibeGrafiktask.Erstauswahl (AuswahlExtern => AktuelleAuswahl);
         
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
               AktuelleAuswahl := SystemKonstanten.AbwählenNegativ;
               exit AuswahlSchleife;
               
            when others =>
               null;
         end case;
         
      end loop AuswahlSchleife;
      
      SchreibeGrafiktask.Eingabeart (EingabeartExtern => GrafikDatentypen.Keine_Eingabe_Enum);
      
      return AktuelleAuswahl;
      
   end AuswahlStadtEinheit;

end AuswahlStadtEinheitLogik;

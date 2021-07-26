pragma SPARK_Mode (On);

with GlobaleKonstanten;

with KIKonstanten, KIDatentypen;
use KIDatentypen;

with KIBewegungDurchfuehren, KINahkampfBodenAufgabeErmitteln, KINahkampfBodenAufgabeDurchfuehren;

package body KINahkampfBoden is

   procedure KINahkampfBoden
     (EinheitRasseNummerExtern : in GlobaleRecords.RassePlatznummerRecord)
   is begin
      
      NotAus := 1;
      
      AktivitätSchleife:
      loop
         
         case
           NotAus
         is
            when 8 =>
               return;
               
            when others =>
               null;
         end case;
         
         if
           GlobaleVariablen.EinheitenGebaut (EinheitRasseNummerExtern.Rasse, EinheitRasseNummerExtern.Platznummer).ID = GlobaleKonstanten.LeerEinheit.ID
           or
             GlobaleVariablen.EinheitenGebaut (EinheitRasseNummerExtern.Rasse, EinheitRasseNummerExtern.Platznummer).Bewegungspunkte <= GlobaleKonstanten.LeerEinheit.Bewegungspunkte
         then
            return;
            
         else
            null;
         end if;
         
         if
           GlobaleVariablen.EinheitenGebaut (EinheitRasseNummerExtern.Rasse, EinheitRasseNummerExtern.Platznummer).KIBeschäftigt = KIDatentypen.Stadt_Bewachen
           and
             GlobaleVariablen.EinheitenGebaut (EinheitRasseNummerExtern.Rasse, EinheitRasseNummerExtern.Platznummer).KIZielKoordinaten = KIKonstanten.NullKoordinate
         then
            return;
            
         else
            null;
         end if;
         
         if
           GlobaleVariablen.EinheitenGebaut (EinheitRasseNummerExtern.Rasse, EinheitRasseNummerExtern.Platznummer).KIZielKoordinaten /= KIKonstanten.NullKoordinate
         then
            KIBewegungDurchfuehren.KIBewegungNeu (EinheitRasseNummerExtern => EinheitRasseNummerExtern);
         
         elsif
           GlobaleVariablen.EinheitenGebaut (EinheitRasseNummerExtern.Rasse, EinheitRasseNummerExtern.Platznummer).Beschäftigung = GlobaleDatentypen.Nicht_Vorhanden
           and
             GlobaleVariablen.EinheitenGebaut (EinheitRasseNummerExtern.Rasse, EinheitRasseNummerExtern.Platznummer).KIBeschäftigt = KIDatentypen.Keine_Aufgabe
         then
            KINahkampfBodenAufgabeErmitteln.NahkampfBodenAufgabeErmitteln (EinheitRasseNummerExtern => EinheitRasseNummerExtern);
         
         else
            null;
         end if;
      
         if
           GlobaleVariablen.EinheitenGebaut (EinheitRasseNummerExtern.Rasse, EinheitRasseNummerExtern.Platznummer).Bewegungspunkte > GlobaleKonstanten.LeerEinheit.Bewegungspunkte
           and
             GlobaleVariablen.EinheitenGebaut (EinheitRasseNummerExtern.Rasse, EinheitRasseNummerExtern.Platznummer).KIZielKoordinaten /= KIKonstanten.NullKoordinate
         then
            null;
            
         elsif
           GlobaleVariablen.EinheitenGebaut (EinheitRasseNummerExtern.Rasse, EinheitRasseNummerExtern.Platznummer).KIZielKoordinaten = KIKonstanten.NullKoordinate
           and
             GlobaleVariablen.EinheitenGebaut (EinheitRasseNummerExtern.Rasse, EinheitRasseNummerExtern.Platznummer).KIBeschäftigt = KIDatentypen.Stadt_Bewachen
           and
             GlobaleVariablen.EinheitenGebaut (EinheitRasseNummerExtern.Rasse, EinheitRasseNummerExtern.Platznummer).Beschäftigung = GlobaleDatentypen.Verschanzen
         then
            return;
            
         elsif
           GlobaleVariablen.EinheitenGebaut (EinheitRasseNummerExtern.Rasse, EinheitRasseNummerExtern.Platznummer).Bewegungspunkte > GlobaleKonstanten.LeerEinheit.Bewegungspunkte
           and
             GlobaleVariablen.EinheitenGebaut (EinheitRasseNummerExtern.Rasse, EinheitRasseNummerExtern.Platznummer).ID > GlobaleKonstanten.LeerEinheit.ID
           and
             GlobaleVariablen.EinheitenGebaut (EinheitRasseNummerExtern.Rasse, EinheitRasseNummerExtern.Platznummer).KIBeschäftigt /= KIDatentypen.Keine_Aufgabe
           and
             GlobaleVariablen.EinheitenGebaut (EinheitRasseNummerExtern.Rasse, EinheitRasseNummerExtern.Platznummer).Beschäftigung = GlobaleDatentypen.Nicht_Vorhanden
           and
             GlobaleVariablen.EinheitenGebaut (EinheitRasseNummerExtern.Rasse, EinheitRasseNummerExtern.Platznummer).KIZielKoordinaten = KIKonstanten.NullKoordinate
         then
            KINahkampfBodenAufgabeDurchfuehren.NahkampfBodenAufgabeDurchfuehren (EinheitRasseNummerExtern => EinheitRasseNummerExtern);
            
         else
            return;
         end if;
         
         NotAus := NotAus + 1;
         
      end loop AktivitätSchleife;
      
   end KINahkampfBoden;

end KINahkampfBoden;

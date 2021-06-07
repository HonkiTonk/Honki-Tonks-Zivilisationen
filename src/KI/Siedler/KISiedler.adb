pragma SPARK_Mode (On);

with Ada.Wide_Wide_Text_IO;
use Ada.Wide_Wide_Text_IO;

with KIDatentypen, KIKonstanten;
use KIDatentypen;

with KIBewegungDurchfuehren, KISiedlerAufgabeErmitteln, KISiedlerAufgabeDurchfuehren;

package body KISiedler is

   procedure KISiedler
     (EinheitRasseNummerExtern : in GlobaleRecords.RassePlatznummerRecord)
   is begin
      
      AktivitätSchleife: -- Letzter Stand (1, 3, 4)
      loop
         
         if
           GlobaleVariablen.EinheitenGebaut (EinheitRasseNummerExtern.Rasse, EinheitRasseNummerExtern.Platznummer).ID = 0
           or
             GlobaleVariablen.EinheitenGebaut (EinheitRasseNummerExtern.Rasse, EinheitRasseNummerExtern.Platznummer).AktuelleBewegungspunkte <= 0.00
         then
            return;
            
         else
            null;
         
            Put_Line ("1");
         end if;
         
         if
           GlobaleVariablen.EinheitenGebaut (EinheitRasseNummerExtern.Rasse, EinheitRasseNummerExtern.Platznummer).KIZielKoordinaten /= KIKonstanten.NullKoordinate
         then
            KIBewegungDurchfuehren.KIBewegungNeu (EinheitRasseNummerExtern => EinheitRasseNummerExtern);
            Put_Line ("2");
         
         elsif
           GlobaleVariablen.EinheitenGebaut (EinheitRasseNummerExtern.Rasse, EinheitRasseNummerExtern.Platznummer).AktuelleBeschäftigung = GlobaleDatentypen.Keine
           and
             GlobaleVariablen.EinheitenGebaut (EinheitRasseNummerExtern.Rasse, EinheitRasseNummerExtern.Platznummer).KIBeschäftigt = KIDatentypen.Keine_Aufgabe
         then
            KISiedlerAufgabeErmitteln.SiedlerAufgabeErmitteln (EinheitRasseNummerExtern => EinheitRasseNummerExtern);
            Put_Line ("3");
         
         else
            null;
            Put_Line ("5");
         end if;
      
         if
           GlobaleVariablen.EinheitenGebaut (EinheitRasseNummerExtern.Rasse, EinheitRasseNummerExtern.Platznummer).AktuelleBewegungspunkte > 0.00
           and
             GlobaleVariablen.EinheitenGebaut (EinheitRasseNummerExtern.Rasse, EinheitRasseNummerExtern.Platznummer).KIZielKoordinaten /= KIKonstanten.NullKoordinate
         then
            null;
            Put_Line ("6");
            
         elsif
           GlobaleVariablen.EinheitenGebaut (EinheitRasseNummerExtern.Rasse, EinheitRasseNummerExtern.Platznummer).AktuelleBewegungspunkte > 0.00
           and
             GlobaleVariablen.EinheitenGebaut (EinheitRasseNummerExtern.Rasse, EinheitRasseNummerExtern.Platznummer).ID > 0
           and
             GlobaleVariablen.EinheitenGebaut (EinheitRasseNummerExtern.Rasse, EinheitRasseNummerExtern.Platznummer).KIBeschäftigt /= KIDatentypen.Keine_Aufgabe
           and
             GlobaleVariablen.EinheitenGebaut (EinheitRasseNummerExtern.Rasse, EinheitRasseNummerExtern.Platznummer).AktuelleBeschäftigung = GlobaleDatentypen.Keine
           and
             GlobaleVariablen.EinheitenGebaut (EinheitRasseNummerExtern.Rasse, EinheitRasseNummerExtern.Platznummer).KIZielKoordinaten = KIKonstanten.NullKoordinate
         then
            KISiedlerAufgabeDurchfuehren.SiedlerAufgabeDurchfuehren (EinheitRasseNummerExtern => EinheitRasseNummerExtern);
            Put_Line ("4");
         
         else
            return;
         end if;
         
      end loop AktivitätSchleife;
      
   end KISiedler;

end KISiedler;

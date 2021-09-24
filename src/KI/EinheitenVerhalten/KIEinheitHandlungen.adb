pragma SPARK_Mode (On);

with GlobaleKonstanten, KartenRecords;
use KartenRecords;

with KIDatentypen, KIKonstanten;
use KIDatentypen;

with LeseEinheitenGebaut;

with KIBewegungDurchfuehren, KIAufgabenPlanung, KIGefahrErmitteln;

package body KIEinheitHandlungen is

   procedure EinheitHandlungen
     (EinheitRasseNummerExtern : in GlobaleRecords.RassePlatznummerRecord)
   is begin
      
      FeindlicheEinheit := KIGefahrErmitteln.GefahrErmitteln (EinheitRasseNummerExtern => EinheitRasseNummerExtern);
            
      case
        FeindlicheEinheit.Rasse
      is
         when GlobaleDatentypen.Leer =>
            NormaleHandlungen (EinheitRasseNummerExtern => EinheitRasseNummerExtern);
            
         when others =>
            GefahrenHandlungen (EinheitRasseNummerExtern => EinheitRasseNummerExtern,
                                FeindlicheEinheitExtern  => FeindlicheEinheit);
      end case;
      
   end EinheitHandlungen;
   
   
   
   procedure NormaleHandlungen
     (EinheitRasseNummerExtern : in GlobaleRecords.RassePlatznummerRecord)
   is begin
      
      AktivitätSchleife:
      for Schleifenwert in GlobaleDatentypen.NotAusKlein'Range loop
         
         exit AktivitätSchleife when HandlungBeendet (EinheitRasseNummerExtern => EinheitRasseNummerExtern) = True;
         
         BewegungAufgabenplanung (EinheitRasseNummerExtern => EinheitRasseNummerExtern);
         
         exit AktivitätSchleife when HandlungBeendet (EinheitRasseNummerExtern => EinheitRasseNummerExtern) = True;
         
         if
           LeseEinheitenGebaut.KIZielKoordinaten (EinheitRasseNummerExtern => EinheitRasseNummerExtern) /= KIKonstanten.LeerKoordinate
         then
            KIBewegungDurchfuehren.KIBewegungNeu (EinheitRasseNummerExtern => EinheitRasseNummerExtern);
            
         elsif
           LeseEinheitenGebaut.KIBeschäftigt (EinheitRasseNummerExtern => EinheitRasseNummerExtern) /= KIDatentypen.Tut_Nichts
           and
             LeseEinheitenGebaut.Beschäftigung (EinheitRasseNummerExtern => EinheitRasseNummerExtern) = GlobaleDatentypen.Leer
         then
            KIAufgabenPlanung.AufgabeUmsetzen (EinheitRasseNummerExtern => EinheitRasseNummerExtern);
         
         else
            return;
         end if;
         
      end loop AktivitätSchleife;
      
   end NormaleHandlungen;
   
   
   
   procedure BewegungAufgabenplanung
     (EinheitRasseNummerExtern : in GlobaleRecords.RassePlatznummerRecord)
   is begin
      
      if
        LeseEinheitenGebaut.KIZielKoordinaten (EinheitRasseNummerExtern => EinheitRasseNummerExtern) /= KIKonstanten.LeerKoordinate
      then
         KIBewegungDurchfuehren.KIBewegungNeu (EinheitRasseNummerExtern => EinheitRasseNummerExtern);
         
      elsif
        LeseEinheitenGebaut.Beschäftigung (EinheitRasseNummerExtern => EinheitRasseNummerExtern) = GlobaleDatentypen.Leer
        and
          LeseEinheitenGebaut.KIBeschäftigt (EinheitRasseNummerExtern => EinheitRasseNummerExtern) = KIDatentypen.Tut_Nichts
      then
         KIAufgabenPlanung.AufgabeErmitteln (EinheitRasseNummerExtern => EinheitRasseNummerExtern);
         
      else
         null;
      end if;
      
   end BewegungAufgabenplanung;
   
   
   
   procedure GefahrenHandlungen
     (EinheitRasseNummerExtern, FeindlicheEinheitExtern : in GlobaleRecords.RassePlatznummerRecord)
   is begin
      
      if
        FeindlicheEinheitExtern.Rasse = GlobaleDatentypen.Leer
      then
         null;
         
      else
         null;
      end if;
      
      AktivitätSchleife:
      for Schleifenwert in GlobaleDatentypen.NotAusKlein'Range loop
         
         exit AktivitätSchleife when HandlungBeendet (EinheitRasseNummerExtern => EinheitRasseNummerExtern) = True;
         
         BewegungAufgabenplanung (EinheitRasseNummerExtern => EinheitRasseNummerExtern);
         
         exit AktivitätSchleife when HandlungBeendet (EinheitRasseNummerExtern => EinheitRasseNummerExtern) = True;
         
         if
           LeseEinheitenGebaut.KIZielKoordinaten (EinheitRasseNummerExtern => EinheitRasseNummerExtern) /= KIKonstanten.LeerKoordinate
         then
            KIBewegungDurchfuehren.KIBewegungNeu (EinheitRasseNummerExtern => EinheitRasseNummerExtern);
            
         elsif
           LeseEinheitenGebaut.KIBeschäftigt (EinheitRasseNummerExtern => EinheitRasseNummerExtern) /= KIDatentypen.Tut_Nichts
           and
             LeseEinheitenGebaut.Beschäftigung (EinheitRasseNummerExtern => EinheitRasseNummerExtern) = GlobaleDatentypen.Leer
         then
            KIAufgabenPlanung.AufgabeUmsetzen (EinheitRasseNummerExtern => EinheitRasseNummerExtern);
         
         else
            return;
         end if;
         
      end loop AktivitätSchleife;
      
   end GefahrenHandlungen;
   
   
   
   function HandlungBeendet
     (EinheitRasseNummerExtern : in GlobaleRecords.RassePlatznummerRecord)
      return Boolean
   is begin
      
      if
        LeseEinheitenGebaut.ID (EinheitRasseNummerExtern => EinheitRasseNummerExtern) = GlobaleKonstanten.LeerEinheit.ID
        or
          LeseEinheitenGebaut.Bewegungspunkte (EinheitRasseNummerExtern => EinheitRasseNummerExtern) <= GlobaleKonstanten.LeerEinheit.Bewegungspunkte
      then
         return True;
         
      elsif
        LeseEinheitenGebaut.KIBeschäftigt (EinheitRasseNummerExtern => EinheitRasseNummerExtern) = KIDatentypen.Stadt_Bewachen
        and
          LeseEinheitenGebaut.KIZielKoordinaten (EinheitRasseNummerExtern => EinheitRasseNummerExtern) = KIKonstanten.LeerKoordinate
      then
         return True;
            
      else
         return False;
      end if;
      
   end HandlungBeendet;

end KIEinheitHandlungen;

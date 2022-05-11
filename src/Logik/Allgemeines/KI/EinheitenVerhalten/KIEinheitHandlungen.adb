pragma SPARK_Mode (On);
pragma Warnings (Off, "*array aggregate*");

with KartenRecords; use KartenRecords;
with EinheitenDatentypen; use EinheitenDatentypen;
with AufgabenDatentypen; use AufgabenDatentypen;
with EinheitenKonstanten;
with ZahlenDatentypen;

with KIDatentypen; use KIDatentypen;
with KIKonstanten;

with LeseEinheitenGebaut;

with KIBewegungDurchfuehren;
with KIAufgabenPlanung;
with KIGefahrErmitteln;

package body KIEinheitHandlungen is

   procedure EinheitHandlungen
     (EinheitRasseNummerExtern : in EinheitenRecords.RasseEinheitnummerRecord)
   is begin
      
      FeindlicheEinheit := KIGefahrErmitteln.GefahrErmitteln (EinheitRasseNummerExtern => EinheitRasseNummerExtern);
            
      case
        FeindlicheEinheit.Rasse
      is
         when EinheitenKonstanten.LeerRasse =>
            NormaleHandlungen (EinheitRasseNummerExtern => EinheitRasseNummerExtern);
            
         when others =>
            GefahrenHandlungen (EinheitRasseNummerExtern => EinheitRasseNummerExtern,
                                FeindlicheEinheitExtern  => FeindlicheEinheit);
      end case;
      
   end EinheitHandlungen;
   
   
   
   procedure NormaleHandlungen
     (EinheitRasseNummerExtern : in EinheitenRecords.RasseEinheitnummerRecord)
   is begin
      
      AktivitätSchleife:
      for Schleifenwert in ZahlenDatentypen.NotAusKlein'Range loop
         
         case
           HandlungBeendet (EinheitRasseNummerExtern => EinheitRasseNummerExtern)
         is
            when True =>
               exit AktivitätSchleife;
               
            when False =>
               BewegungAufgabenplanung (EinheitRasseNummerExtern => EinheitRasseNummerExtern);
         end case;
         
         case
           HandlungBeendet (EinheitRasseNummerExtern => EinheitRasseNummerExtern)
         is
            when True =>
               exit AktivitätSchleife;
               
            when False =>
               null;
         end case;
         
         if
           LeseEinheitenGebaut.KIZielKoordinaten (EinheitRasseNummerExtern => EinheitRasseNummerExtern) /= KIKonstanten.LeerKoordinate
         then
            KIBewegungDurchfuehren.KIBewegungNeu (EinheitRasseNummerExtern => EinheitRasseNummerExtern);
            
         elsif
           LeseEinheitenGebaut.KIBeschäftigt (EinheitRasseNummerExtern => EinheitRasseNummerExtern) /= KIDatentypen.Tut_Nichts_Enum
           and
             LeseEinheitenGebaut.Beschäftigung (EinheitRasseNummerExtern => EinheitRasseNummerExtern) = EinheitenKonstanten.LeerBeschäftigung
         then
            KIAufgabenPlanung.AufgabeUmsetzen (EinheitRasseNummerExtern => EinheitRasseNummerExtern);
         
         else
            return;
         end if;
         
      end loop AktivitätSchleife;
      
   end NormaleHandlungen;
   
   
   
   procedure BewegungAufgabenplanung
     (EinheitRasseNummerExtern : in EinheitenRecords.RasseEinheitnummerRecord)
   is begin
      
      if
        LeseEinheitenGebaut.KIZielKoordinaten (EinheitRasseNummerExtern => EinheitRasseNummerExtern) /= KIKonstanten.LeerKoordinate
      then
         KIBewegungDurchfuehren.KIBewegungNeu (EinheitRasseNummerExtern => EinheitRasseNummerExtern);
         
      elsif
        LeseEinheitenGebaut.Beschäftigung (EinheitRasseNummerExtern => EinheitRasseNummerExtern) = EinheitenKonstanten.LeerBeschäftigung
        and
          LeseEinheitenGebaut.KIBeschäftigt (EinheitRasseNummerExtern => EinheitRasseNummerExtern) = KIDatentypen.Tut_Nichts_Enum
      then
         KIAufgabenPlanung.AufgabeErmitteln (EinheitRasseNummerExtern => EinheitRasseNummerExtern);
         
      else
         null;
      end if;
      
   end BewegungAufgabenplanung;
   
   
   
   procedure GefahrenHandlungen
     (EinheitRasseNummerExtern : in EinheitenRecords.RasseEinheitnummerRecord;
      FeindlicheEinheitExtern : in EinheitenRecords.RasseEinheitnummerRecord)
   is begin
      
      if
        FeindlicheEinheitExtern.Rasse = EinheitenKonstanten.LeerRasse
      then
         null;
         
      else
         null;
      end if;
      
      AktivitätSchleife:
      for Schleifenwert in ZahlenDatentypen.NotAusKlein'Range loop
         
         case
           HandlungBeendet (EinheitRasseNummerExtern => EinheitRasseNummerExtern)
         is
            when True =>
               exit AktivitätSchleife;
               
            when False =>
               BewegungAufgabenplanung (EinheitRasseNummerExtern => EinheitRasseNummerExtern);
         end case;
         
         case
           HandlungBeendet (EinheitRasseNummerExtern => EinheitRasseNummerExtern)
         is
            when True =>
               exit AktivitätSchleife;
               
            when False =>
               null;
         end case;
         
         if
           LeseEinheitenGebaut.KIZielKoordinaten (EinheitRasseNummerExtern => EinheitRasseNummerExtern) /= KIKonstanten.LeerKoordinate
         then
            KIBewegungDurchfuehren.KIBewegungNeu (EinheitRasseNummerExtern => EinheitRasseNummerExtern);
            
         elsif
           LeseEinheitenGebaut.KIBeschäftigt (EinheitRasseNummerExtern => EinheitRasseNummerExtern) /= KIDatentypen.Tut_Nichts_Enum
           and
             LeseEinheitenGebaut.Beschäftigung (EinheitRasseNummerExtern => EinheitRasseNummerExtern) = EinheitenKonstanten.LeerBeschäftigung
         then
            KIAufgabenPlanung.AufgabeUmsetzen (EinheitRasseNummerExtern => EinheitRasseNummerExtern);
         
         else
            return;
         end if;
         
      end loop AktivitätSchleife;
      
   end GefahrenHandlungen;
   
   
   
   function HandlungBeendet
     (EinheitRasseNummerExtern : in EinheitenRecords.RasseEinheitnummerRecord)
      return Boolean
   is begin
      
      if
        LeseEinheitenGebaut.ID (EinheitRasseNummerExtern => EinheitRasseNummerExtern) = EinheitenKonstanten.LeerEinheit.ID
        or
          LeseEinheitenGebaut.Bewegungspunkte (EinheitRasseNummerExtern => EinheitRasseNummerExtern) <= EinheitenKonstanten.LeerBewegungspunkte
      then
         return True;
         
      elsif
        LeseEinheitenGebaut.KIBeschäftigt (EinheitRasseNummerExtern => EinheitRasseNummerExtern) = KIDatentypen.Stadt_Bewachen_Enum
        and
          LeseEinheitenGebaut.KIZielKoordinaten (EinheitRasseNummerExtern => EinheitRasseNummerExtern) = KIKonstanten.LeerKoordinate
      then
         return True;
            
      else
         return False;
      end if;
      
   end HandlungBeendet;

end KIEinheitHandlungen;

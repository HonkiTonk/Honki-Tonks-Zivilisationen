pragma SPARK_Mode (On);
pragma Warnings (Off, "*array aggregate*");

with EinheitenRecords; use EinheitenRecords;
with ForschungenDatentypen; use ForschungenDatentypen;
with EinheitenKonstanten;
with ForschungKonstanten;
with TastenbelegungDatentypen;

with LeseWichtiges;

with KIDatentypen; use KIDatentypen;

with KIGefahrErmitteln;
with KIGrenzpruefungen;

package body KIEinheitAufgabeVerbesserungen is

   function StadtumgebungVerbessern
     (EinheitRasseNummerExtern : in EinheitenRecords.RasseEinheitnummerRecord)
      return KIDatentypen.AufgabenWichtigkeitKlein
   is begin
      
      if
        KIGefahrErmitteln.GefahrErmitteln (EinheitRasseNummerExtern => EinheitRasseNummerExtern) = EinheitenKonstanten.LeerRasseNummer
      then
         Gesamtwert := MöglicheVerbesserungen (RasseExtern => EinheitRasseNummerExtern.Rasse);
         
      else
         Gesamtwert := -1;
      end if;
      
      return Gesamtwert;
            
   end StadtumgebungVerbessern;
   
   
   
   function MöglicheVerbesserungen
     (RasseExtern : in RassenDatentypen.Rassen_Verwendet_Enum)
      return KIDatentypen.AufgabenWichtigkeitKlein
   is begin
      
      Zwischenwert := 0;
      
      AufgabenSchleife:
      for AufgabeSchleifenwert in TastenbelegungDatentypen.Tastenbelegung_Verbesserung_Befehle_Enum'Range loop
         
         NötigeTechnologie := ForschungKonstanten.TechnologieVerbesserung (RasseExtern, AufgabeSchleifenwert);
         
         if
           NötigeTechnologie = ForschungKonstanten.LeerForschung
         then
            Zwischenwert := KIGrenzpruefungen.AufgabenWichtigkeit (AktuellerWertExtern => Zwischenwert,
                                                                   ÄnderungExtern      => 2);
            
         elsif
           LeseWichtiges.Erforscht (RasseExtern             => RasseExtern,
                                    WelcheTechnologieExtern => NötigeTechnologie)
           = True
         then
            Zwischenwert := KIGrenzpruefungen.AufgabenWichtigkeit (AktuellerWertExtern => Zwischenwert,
                                                                   ÄnderungExtern      => 2);
            
         else
            null;
         end if;
         
      end loop AufgabenSchleife;
      
      return Zwischenwert;
      
   end MöglicheVerbesserungen;

end KIEinheitAufgabeVerbesserungen;

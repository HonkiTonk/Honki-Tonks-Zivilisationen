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
-- with KIGrenzpruefungen;

package body KIEinheitAufgabeVerbesserungen is

   function StadtumgebungVerbessern
     (EinheitRasseNummerExtern : in EinheitenRecords.RasseEinheitnummerRecord)
      return KIDatentypen.AufgabenWichtigkeitKlein
   is begin
      
      if
        KIGefahrErmitteln.GefahrErmitteln (EinheitRasseNummerExtern => EinheitRasseNummerExtern) = EinheitenKonstanten.LeerRasseNummer
      then
         return MöglicheVerbesserungen (RasseExtern => EinheitRasseNummerExtern.Rasse);
         
      else
         return -1;
      end if;
            
   end StadtumgebungVerbessern;
   
   
   
   ---------------------------- Rassenarray anlegen wie bei Einheit auflösen?
   ---------------------------- Was tun wenn nichts mehr zu verbessern ist? Die Stadt die Verbesserungen befehlen lassen?
   function MöglicheVerbesserungen
     (RasseExtern : in RassenDatentypen.Rassen_Verwendet_Enum)
      return KIDatentypen.AufgabenWichtigkeitKlein
   is begin
            
      AufgabenSchleife:
      for AufgabeSchleifenwert in TastenbelegungDatentypen.Tastenbelegung_Konstruktionen_Enum'Range loop
         
         NötigeTechnologie := ForschungKonstanten.TechnologieVerbesserung (RasseExtern, AufgabeSchleifenwert);
         
         -------------------------- Hier nicht die Funktion ForschungAllgemein.TechnologieVorhanden verwenden um später eine bessere Bewertung einbauen zu können.
         if
           NötigeTechnologie = ForschungKonstanten.LeerForschung
         then
            null;
            -- Zwischenwert := KIGrenzpruefungen.AufgabenWichtigkeit (AktuellerWertExtern => Zwischenwert,
            --                                                        ÄnderungExtern      => 10);
            
         elsif
           LeseWichtiges.Erforscht (RasseExtern             => RasseExtern,
                                    WelcheTechnologieExtern => NötigeTechnologie)
           = True
         then
            return AuchVerbesserungen;
            
         else
            null;
         end if;
         
      end loop AufgabenSchleife;
      
      return NurWege;
      
   end MöglicheVerbesserungen;

end KIEinheitAufgabeVerbesserungen;

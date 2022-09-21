pragma SPARK_Mode (On);
pragma Warnings (Off, "*array aggregate*");

with EinheitenRecords; use EinheitenRecords;
with ForschungenDatentypen; use ForschungenDatentypen;
with EinheitenKonstanten;
with ForschungKonstanten;
with TastenbelegungDatentypen;

with LeseWichtiges;
with LeseForschungenDatenbank;

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
   
   
   
   -- Rassenarray anlegen wie bei Einheit auflösen? äöü
   -- Was tun wenn nichts mehr zu verbessern ist? Die Stadt die Verbesserungen befehlen lassen? äöü
   function MöglicheVerbesserungen
     (RasseExtern : in RassenDatentypen.Rassen_Verwendet_Enum)
      return KIDatentypen.AufgabenWichtigkeitKlein
   is begin
            
      AufgabenSchleife:
      for AufgabeSchleifenwert in TastenbelegungDatentypen.Tastenbelegung_Konstruktionen_Enum'Range loop
         
         NötigeTechnologie := LeseForschungenDatenbank.Verbesserungen (VerbesserungExtern => AufgabeSchleifenwert,
                                                                       RasseExtern        => RasseExtern);
         
         -- Hier nicht die Funktion ForschungstestsLogik.TechnologieVorhanden verwenden um später eine bessere Bewertung einbauen zu können. äöü
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

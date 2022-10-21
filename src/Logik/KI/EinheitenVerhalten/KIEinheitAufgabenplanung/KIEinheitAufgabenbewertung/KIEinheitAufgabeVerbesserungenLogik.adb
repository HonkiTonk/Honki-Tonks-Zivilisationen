pragma SPARK_Mode (On);
pragma Warnings (Off, "*array aggregate*");

with EinheitenRecords; use EinheitenRecords;
with ForschungenDatentypen; use ForschungenDatentypen;
with EinheitenKonstanten;
with ForschungKonstanten;
with BefehleDatentypen;

with LeseWichtiges;
with LeseForschungenDatenbank;

with KIKonstanten;

with KIGefahrErmittelnLogik;
-- with KIGrenzpruefungen;

package body KIEinheitAufgabeVerbesserungenLogik is

   function StadtumgebungVerbessern
     (EinheitRasseNummerExtern : in EinheitenRecords.RasseEinheitnummerRecord)
      return KIDatentypen.AufgabenWichtigkeitKlein
   is begin
      
      if
        KIGefahrErmittelnLogik.GefahrErmitteln (EinheitRasseNummerExtern => EinheitRasseNummerExtern) = EinheitenKonstanten.LeerRasseNummer
      then
         return MöglicheVerbesserungen (RasseExtern => EinheitRasseNummerExtern.Rasse);
         
      else
         return KIKonstanten.UnmöglichAufgabenbewertung;
      end if;
            
   end StadtumgebungVerbessern;
   
   
   
   -- Rassenarray anlegen wie bei Einheit auflösen? äöü
   -- Was tun wenn nichts mehr zu verbessern ist? Die Stadt die Verbesserungen befehlen lassen? äöü
   function MöglicheVerbesserungen
     (RasseExtern : in RassenDatentypen.Rassen_Verwendet_Enum)
      return KIDatentypen.AufgabenWichtigkeitKlein
   is begin
            
      AufgabenSchleife:
      for AufgabeSchleifenwert in BefehleDatentypen.Siedler_Konstruktionen_Enum'Range loop
         
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
           True = LeseWichtiges.Erforscht (RasseExtern             => RasseExtern,
                                           WelcheTechnologieExtern => NötigeTechnologie)
         then
            return AuchVerbesserungen;
            
         else
            null;
         end if;
         
      end loop AufgabenSchleife;
      
      return NurWege;
      
   end MöglicheVerbesserungen;

end KIEinheitAufgabeVerbesserungenLogik;

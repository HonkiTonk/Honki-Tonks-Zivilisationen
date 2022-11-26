with StadtKonstanten;

with LeseWichtiges;

with KIDatentypen;

with LeseKIVariablen;

with KIAufgabenVerteiltLogik;
with KIEinheitFestlegenSiedelnLogik;
with KIEinheitFestlegenVerbesserungenLogik;
with KIEinheitFestlegenHeilenLogik;
with KIEinheitFestlegenAufloesenLogik;
with KIEinheitFestlegenFliehenLogik;
with KIEinheitFestlegenBefestigenLogik;
with KIEinheitFestlegenNichtsLogik;
with KIGefahrErmittelnLogik;

package body KISiedleraufgabenLogik is

   procedure Siedleraufgaben
     (EinheitRasseNummerExtern : in EinheitenRecords.RasseEinheitnummerRecord)
   is
      use type StadtDatentypen.MaximaleStädteMitNullWert;
   begin
      
      VorhandeneStädte := LeseWichtiges.AnzahlStädte (RasseExtern => EinheitRasseNummerExtern.Rasse);
      
      if
        VorhandeneStädte = StadtKonstanten.LeerNummer
        and then
          KIEinheitFestlegenSiedelnLogik.StadtBauen (EinheitRasseNummerExtern => EinheitRasseNummerExtern) = True
      then
         return;
         
      else
         null;
      end if;
      
      case
        LeseKIVariablen.Kriegszustand
      is
         when False =>
            NormaleAufgaben (EinheitRasseNummerExtern => EinheitRasseNummerExtern);
            
         when True =>
            Kriegsaufgaben (EinheitRasseNummerExtern => EinheitRasseNummerExtern);
      end case;
      
   end Siedleraufgaben;
   
   
   
   -- Siedler auch Verbessern? äöü
   procedure NormaleAufgaben
     (EinheitRasseNummerExtern : in EinheitenRecords.RasseEinheitnummerRecord)
   is
      use type StadtDatentypen.MaximaleStädteMitNullWert;
   begin
      
      if
        KIEinheitFestlegenVerbesserungenLogik.StadtumgebungVerbessern (EinheitRasseNummerExtern => EinheitRasseNummerExtern) = True
      then
         null;
         
      elsif
        (VorhandeneStädte < LeseGrenzen.Städtegrenzen (RasseExtern => EinheitRasseNummerExtern.Rasse)
         and
           1 > KIAufgabenVerteiltLogik.AufgabenVerteilt (EinheitRasseNummerExtern => EinheitRasseNummerExtern,
                                                         AufgabeExtern            => KIDatentypen.Stadt_Bauen_Enum))
        and then
          KIEinheitFestlegenSiedelnLogik.StadtBauen (EinheitRasseNummerExtern => EinheitRasseNummerExtern) = True
      then
         null;
         
      elsif
        KIEinheitFestlegenHeilenLogik.Heilen (EinheitRasseNummerExtern => EinheitRasseNummerExtern) = True
      then
         null;
         
      elsif
        KIEinheitFestlegenAufloesenLogik.EinheitAuflösen (EinheitRasseNummerExtern => EinheitRasseNummerExtern) = True
      then
         null;
         
         -- Hier noch eine Prüfung einbauen ob eine andere Einheit auf das Feld dieser Einheit will und dann aus dem Weg gehen? äöü
      else
         KIEinheitFestlegenNichtsLogik.NichtsTun (EinheitRasseNummerExtern => EinheitRasseNummerExtern);
      end if;
      
   end NormaleAufgaben;
     
   
   
   procedure Kriegsaufgaben
     (EinheitRasseNummerExtern : in EinheitenRecords.RasseEinheitnummerRecord)
   is begin
      
      case
        KIGefahrErmittelnLogik.GefahrSuchen (EinheitRasseNummerExtern => EinheitRasseNummerExtern).Nummer
      is
         when EinheitenKonstanten.LeerNummer =>
            NormaleAufgaben (EinheitRasseNummerExtern => EinheitRasseNummerExtern);
            
         when others =>
            if
              KIEinheitFestlegenFliehenLogik.Fliehen (EinheitRasseNummerExtern => EinheitRasseNummerExtern) = True
            then
               null;
         
            elsif
              KIEinheitFestlegenBefestigenLogik.Befestigen (EinheitRasseNummerExtern => EinheitRasseNummerExtern) = True
            then
               null;
         
            else
               KIEinheitFestlegenNichtsLogik.NichtsTun (EinheitRasseNummerExtern => EinheitRasseNummerExtern);
            end if;
      end case;
      
   end Kriegsaufgaben;

end KISiedleraufgabenLogik;

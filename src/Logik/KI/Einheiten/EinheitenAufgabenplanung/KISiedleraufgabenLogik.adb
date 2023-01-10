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
     (EinheitSpeziesNummerExtern : in EinheitenRecords.SpeziesEinheitnummerRecord)
   is
      use type StadtDatentypen.MaximaleStädteMitNullWert;
   begin
      
      VorhandeneStädte := LeseWichtiges.AnzahlStädte (SpeziesExtern => EinheitSpeziesNummerExtern.Spezies);
      
      if
        VorhandeneStädte = StadtKonstanten.LeerNummer
        and then
          KIEinheitFestlegenSiedelnLogik.StadtBauen (EinheitSpeziesNummerExtern => EinheitSpeziesNummerExtern) = True
      then
         return;
         
      else
         null;
      end if;
      
      case
        LeseKIVariablen.Kriegszustand
      is
         when False =>
            NormaleAufgaben (EinheitSpeziesNummerExtern => EinheitSpeziesNummerExtern);
            
         when True =>
            Kriegsaufgaben (EinheitSpeziesNummerExtern => EinheitSpeziesNummerExtern);
      end case;
      
   end Siedleraufgaben;
   
   
   
   -- Siedler auch Verbessern? äöü
   procedure NormaleAufgaben
     (EinheitSpeziesNummerExtern : in EinheitenRecords.SpeziesEinheitnummerRecord)
   is
      use type StadtDatentypen.MaximaleStädteMitNullWert;
   begin
      
      if
        KIEinheitFestlegenVerbesserungenLogik.StadtumgebungVerbessern (EinheitSpeziesNummerExtern => EinheitSpeziesNummerExtern) = True
      then
         null;
         
      elsif
        (VorhandeneStädte < LeseGrenzen.Städtegrenzen (SpeziesExtern => EinheitSpeziesNummerExtern.Spezies)
         and
           1 > KIAufgabenVerteiltLogik.AufgabenVerteilt (EinheitSpeziesNummerExtern => EinheitSpeziesNummerExtern,
                                                         AufgabeExtern            => KIDatentypen.Stadt_Bauen_Enum))
        and then
          KIEinheitFestlegenSiedelnLogik.StadtBauen (EinheitSpeziesNummerExtern => EinheitSpeziesNummerExtern) = True
      then
         null;
         
      elsif
        KIEinheitFestlegenHeilenLogik.Heilen (EinheitSpeziesNummerExtern => EinheitSpeziesNummerExtern) = True
      then
         null;
         
      elsif
        KIEinheitFestlegenAufloesenLogik.EinheitAuflösen (EinheitSpeziesNummerExtern => EinheitSpeziesNummerExtern) = True
      then
         null;
         
         -- Hier noch eine Prüfung einbauen ob eine andere Einheit auf das Feld dieser Einheit will und dann aus dem Weg gehen? äöü
      else
         KIEinheitFestlegenNichtsLogik.NichtsTun (EinheitSpeziesNummerExtern => EinheitSpeziesNummerExtern);
      end if;
      
   end NormaleAufgaben;
     
   
   
   procedure Kriegsaufgaben
     (EinheitSpeziesNummerExtern : in EinheitenRecords.SpeziesEinheitnummerRecord)
   is begin
      
      case
        KIGefahrErmittelnLogik.GefahrSuchen (EinheitSpeziesNummerExtern => EinheitSpeziesNummerExtern).Nummer
      is
         when EinheitenKonstanten.LeerNummer =>
            NormaleAufgaben (EinheitSpeziesNummerExtern => EinheitSpeziesNummerExtern);
            
         when others =>
            if
              KIEinheitFestlegenFliehenLogik.Fliehen (EinheitSpeziesNummerExtern => EinheitSpeziesNummerExtern) = True
            then
               null;
         
            elsif
              KIEinheitFestlegenBefestigenLogik.Befestigen (EinheitSpeziesNummerExtern => EinheitSpeziesNummerExtern) = True
            then
               null;
         
            else
               KIEinheitFestlegenNichtsLogik.NichtsTun (EinheitSpeziesNummerExtern => EinheitSpeziesNummerExtern);
            end if;
      end case;
      
   end Kriegsaufgaben;

end KISiedleraufgabenLogik;

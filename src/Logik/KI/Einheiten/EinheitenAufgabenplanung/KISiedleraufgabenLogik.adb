with StadtKonstanten;
with StadtDatentypen;

with LeseWichtiges;

with LeseKIVariablen;

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
   is begin
      
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
   is begin
      
      if
        KIEinheitFestlegenSiedelnLogik.StadtBauen (EinheitSpeziesNummerExtern => EinheitSpeziesNummerExtern) = True
      then
         null;
         
      elsif
        KIEinheitFestlegenVerbesserungenLogik.StadtumgebungVerbessern (EinheitSpeziesNummerExtern => EinheitSpeziesNummerExtern) = True
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
         
         -- Hier noch eine Prüfung einbauen ob eine andere Einheit auf das Feld dieser Einheit will und dann aus dem Weg gehen. äöü
      else
         KIEinheitFestlegenNichtsLogik.NichtsTun (EinheitSpeziesNummerExtern => EinheitSpeziesNummerExtern);
      end if;
      
   end NormaleAufgaben;
     
   
   
   procedure Kriegsaufgaben
     (EinheitSpeziesNummerExtern : in EinheitenRecords.SpeziesEinheitnummerRecord)
   is
      use type StadtDatentypen.MaximaleStädteMitNullWert;
   begin
      
      -- Hier später noch weitere Prüfungen einbauen, beispielsweise den Stadtplatz mit maximalster Entfernung zum Feind. äöü
      if
        LeseWichtiges.AnzahlStädte (SpeziesExtern => EinheitSpeziesNummerExtern.Spezies) = StadtKonstanten.LeerNummer
        and then
          KIEinheitFestlegenSiedelnLogik.StadtBauen (EinheitSpeziesNummerExtern => EinheitSpeziesNummerExtern) = True
      then
         return;
         
      else
         null;
      end if;
      
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

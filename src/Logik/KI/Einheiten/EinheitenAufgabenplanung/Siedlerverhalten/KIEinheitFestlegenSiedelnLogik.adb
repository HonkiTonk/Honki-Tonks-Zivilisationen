with KartenRecordKonstanten;
with StadtKonstanten;

with SchreibeEinheitenGebaut;
with LeseWichtiges;
with LeseSpeziesDatenbank;
with LeseAllgemeines;

with KIDatentypen;

with KIZielSuchenLogik;
with KIAufgabenVerteiltLogik;

package body KIEinheitFestlegenSiedelnLogik is

   function StadtBauen
     (EinheitSpeziesNummerExtern : in EinheitenRecords.SpeziesEinheitnummerRecord)
      return Boolean
   is
      use type KartenRecords.AchsenKartenfeldNaturalRecord;
      use type StadtDatentypen.MaximaleStädteMitNullWert;
   begin
      
      AnzahlStädte := LeseWichtiges.AnzahlStädte (SpeziesExtern => EinheitSpeziesNummerExtern.Spezies);
      
      if
        AnzahlStädte = StadtKonstanten.LeerNummer
      then
         null;
         
      elsif
        AnzahlStädte < LeseGrenzen.Städtegrenzen (SpeziesExtern => EinheitSpeziesNummerExtern.Spezies)
        and
          0 = KIAufgabenVerteiltLogik.AufgabenVerteilt (EinheitSpeziesNummerExtern => EinheitSpeziesNummerExtern,
                                                        AufgabeExtern              => KIDatentypen.Stadt_Bauen_Enum)
        and
          LeseAllgemeines.Rundenanzahl mod Positive (LeseSpeziesDatenbank.SpeziesExpansion (SpeziesExtern => EinheitSpeziesNummerExtern.Spezies)) = 0
      then
         null;
         
      else
         return False;
      end if;
      
      NeueStadtKoordinaten := KIZielSuchenLogik.ZielSuchen (EinheitSpeziesNummerExtern => EinheitSpeziesNummerExtern,
                                                            ZielartExtern              => KIDatentypen.Siedeln_Enum);
      
      case
        NeueStadtKoordinaten = KartenRecordKonstanten.LeerKoordinate
      is
         when True =>
            return False;
            
         when False =>
            SchreibeEinheitenGebaut.KIZielKoordinaten (EinheitSpeziesNummerExtern => EinheitSpeziesNummerExtern,
                                                       KoordinatenExtern          => NeueStadtKoordinaten);
            SchreibeEinheitenGebaut.KIBeschäftigt (EinheitSpeziesNummerExtern => EinheitSpeziesNummerExtern,
                                                    AufgabeExtern              => KIDatentypen.Stadt_Bauen_Enum);
            return True;
      end case;
      
   end StadtBauen;

end KIEinheitFestlegenSiedelnLogik;

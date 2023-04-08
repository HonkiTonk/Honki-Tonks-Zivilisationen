with BefehleDatentypen;
with AufgabenDatentypen;
with KartenverbesserungDatentypen;

with SchreibeEinheitenGebaut;
with LeseStadtGebaut;

with AufgabenLogik;

package body KIEinheitFestlegenWegeLogik is

   function WegAnlegbar
     (KoordinatenExtern : in KartenRecords.AchsenKartenfeldNaturalRecord;
      EinheitSpeziesNummerExtern : in EinheitenRecords.SpeziesEinheitnummerRecord)
      return Boolean
   is begin
      
      case
        AufgabenLogik.Aufgabe (EinheitSpeziesNummerExtern => EinheitSpeziesNummerExtern,
                               BefehlExtern               => BefehleDatentypen.Straße_Bauen_Enum,
                               AnlegenTestenExtern        => False,
                               KoordinatenExtern          => KoordinatenExtern)
      is
         when True =>
            SchreibeEinheitenGebaut.KIVerbesserung (EinheitSpeziesNummerExtern => EinheitSpeziesNummerExtern,
                                                    BeschäftigungExtern        => AufgabenDatentypen.Straße_Bauen_Enum);
            return True;
            
         when False =>
            return False;
      end case;
      
   end WegAnlegbar;
   
   
   
   -- Eventuell sollte ich speichern welche Städte miteinander verbunden sind, damit diese Prüfungen hier nicht immer wieder durchlaufen müssen. äöü
   function StädteVerbinden
     (EinheitSpeziesNummerExtern : in EinheitenRecords.SpeziesEinheitnummerRecord)
      return Boolean
   is
      use type StadtDatentypen.MaximaleStädteMitNullWert;
      use type KartenverbesserungDatentypen.Karten_Verbesserung_Enum;
   begin

      Stadtgrenze := LeseGrenzen.Städtegrenzen (SpeziesExtern => EinheitSpeziesNummerExtern.Spezies);
      WegGefunden := False;
      
      AnfangsstadtSchleife:
      for AnfangsstadtSchleifenwert in StadtKonstanten.AnfangNummer .. Stadtgrenze loop
         EndstadtSchleife:
         for EndstadtSchleifenwert in StadtKonstanten.AnfangNummer + 1 .. Stadtgrenze loop
            
            if
              LeseStadtGebaut.ID (StadtSpeziesNummerExtern => (EinheitSpeziesNummerExtern.Spezies, AnfangsstadtSchleifenwert)) = StadtKonstanten.LeerID
            then
               exit EndstadtSchleife;
               
            elsif
              LeseStadtGebaut.ID (StadtSpeziesNummerExtern => (EinheitSpeziesNummerExtern.Spezies, EndstadtSchleifenwert)) = StadtKonstanten.LeerID
            then
               null;
               
            elsif
              True = VerbindungMöglich (AnfangsstadtExtern         => (EinheitSpeziesNummerExtern.Spezies, AnfangsstadtSchleifenwert),
                                         EndstadtExtern             => (EinheitSpeziesNummerExtern.Spezies, EndstadtSchleifenwert),
                                         EinheitSpeziesNummerExtern => EinheitSpeziesNummerExtern)
            then
               WegGefunden := True;
               exit AnfangsstadtSchleife;
              
            else
               null;
            end if;

         end loop EndstadtSchleife;
      end loop AnfangsstadtSchleife;
      
      return WegGefunden;
      
   end StädteVerbinden;
   
   
   
   function VerbindungMöglich
     (AnfangsstadtExtern : in StadtRecords.SpeziesStadtnummerRecord;
      EndstadtExtern : in StadtRecords.SpeziesStadtnummerRecord;
      EinheitSpeziesNummerExtern : in EinheitenRecords.SpeziesEinheitnummerRecord)
      return Boolean
   is
      use type KartenDatentypen.Ebene;
   begin
            
      KoordinatenAnfangsstadt := LeseStadtGebaut.Koordinaten (StadtSpeziesNummerExtern => AnfangsstadtExtern);
      KoordinatenEndstadt := LeseStadtGebaut.Koordinaten (StadtSpeziesNummerExtern => EndstadtExtern);
               
      if
        KoordinatenAnfangsstadt.EAchse = KoordinatenEndstadt.EAchse
      then
         SchreibeEinheitenGebaut.KIZielKoordinaten (EinheitSpeziesNummerExtern => EinheitSpeziesNummerExtern,
                                                    KoordinatenExtern          => KoordinatenEndstadt);
                  
      else
         return False;
      end if;
      
      
      
      return False;
      
   end VerbindungMöglich;

end KIEinheitFestlegenWegeLogik;

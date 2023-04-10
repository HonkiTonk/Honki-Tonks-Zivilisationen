with BefehleDatentypen;
with AufgabenDatentypen;
with KartenKonstanten;
with EinheitenDatentypen;
with KartenRecordKonstanten;

with SchreibeEinheitenGebaut;

with AufgabenLogik;

with KIDatentypen;
with KIVariablen;
with KIKonstanten;

with KIAufgabenVerteiltLogik;
with KIStaedteverbindungssystemLogik;

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
   
   
   
   function StädteVerbinden
     (EinheitSpeziesNummerExtern : in EinheitenRecords.SpeziesEinheitnummerRecord)
      return KartenRecords.AchsenKartenfeldNaturalRecord
   is
      use type KartenRecords.AchsenKartenfeldNaturalRecord;
   begin
      
      case
        KIVariablen.Stadtverbindung (EinheitSpeziesNummerExtern.Spezies, KIKonstanten.VerbindungsplanVorhanden).XAchse
      is
         when KartenKonstanten.LeerXAchse =>
            return KartenRecordKonstanten.LeerKoordinate;
            
         when others =>
            null;
      end case;
      
      VerbindungSchleife:
      for VerbindungSchleifenwert in EinheitenDatentypen.BewegungsplanVorhanden'Range loop
         
         Koordinaten := KIVariablen.Stadtverbindung (EinheitSpeziesNummerExtern.Spezies, VerbindungSchleifenwert);
                  
         if
           Koordinaten = KartenRecordKonstanten.LeerKoordinate
         then
            null;
            
         elsif
           True = KIAufgabenVerteiltLogik.EinheitAufgabeZiel (AufgabeExtern         => KIDatentypen.Verbesserung_Anlegen_Enum,
                                                              SpeziesExtern         => EinheitSpeziesNummerExtern.Spezies,
                                                              ZielKoordinatenExtern => Koordinaten)
         then
            null;
            
         elsif
           True = AufgabenLogik.Aufgabe (EinheitSpeziesNummerExtern => EinheitSpeziesNummerExtern,
                                         BefehlExtern               => BefehleDatentypen.Straße_Bauen_Enum,
                                         AnlegenTestenExtern        => False,
                                         KoordinatenExtern          => Koordinaten)
         then
            SchreibeEinheitenGebaut.KIVerbesserung (EinheitSpeziesNummerExtern => EinheitSpeziesNummerExtern,
                                                    BeschäftigungExtern        => AufgabenDatentypen.Straße_Bauen_Enum);
            KIStaedteverbindungssystemLogik.ElementEntfernen (SpeziesExtern => EinheitSpeziesNummerExtern.Spezies,
                                                              ElementExtern => VerbindungSchleifenwert);
            
            return Koordinaten;
            
         else
            null;
         end if;
                  
      end loop VerbindungSchleife;
      
      return KartenRecordKonstanten.LeerKoordinate;
      
   end StädteVerbinden;

end KIEinheitFestlegenWegeLogik;

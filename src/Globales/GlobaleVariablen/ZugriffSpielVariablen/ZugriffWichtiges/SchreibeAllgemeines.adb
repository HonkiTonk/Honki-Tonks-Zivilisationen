with SpielVariablen;
with WichtigesRecordKonstanten;

package body SchreibeAllgemeines is
   
   -- Später erweitern damit man weiß wer gewonnen hat. äöü
   procedure Gewonnen
   is begin
      
      SpielVariablen.Allgemeines.Gewonnen := True;
      
   end Gewonnen;
   
   
   
   procedure Weiterspielen
     (WeiterspielenExtern : in Boolean)
   is begin
      
      SpielVariablen.Allgemeines.Weiterspielen := WeiterspielenExtern;
      
   end Weiterspielen;
   
   
   
   procedure SpeziesAmzugNachLaden
     (SpeziesExtern : in SpeziesDatentypen.Spezies_Enum)
   is begin
      
      SpielVariablen.Allgemeines.SpeziesAmZugNachLaden := SpeziesExtern;
      
   end SpeziesAmzugNachLaden;
   
      
   
   procedure Schwierigkeitsgrad
     (SchwierigkeitsgradExtern : in SpielDatentypen.Schwierigkeitsgrad_Enum)
   is begin
      
      SpielVariablen.Allgemeines.Schwierigkeitsgrad := SchwierigkeitsgradExtern;
      
   end Schwierigkeitsgrad;
   
      
   
   procedure Rundenanzahl
   is begin
      
      SpielVariablen.Allgemeines.Rundenanzahl := EigeneZahlPrüfen (AktuellerWertExtern => SpielVariablen.Allgemeines.Rundenanzahl,
                                                                    ÄnderungExtern      => 1);
      
   end Rundenanzahl;
   
   
      
   procedure Rundengrenze
     (RundengrenzeExtern : in ZahlenDatentypen.EigenesNatural)
   is begin
      
      SpielVariablen.Allgemeines.Rundengrenze := RundengrenzeExtern;
      
   end Rundengrenze;
   
   
      
   procedure Ironman
     (NameExtern : in Unbounded_Wide_Wide_String)
   is begin
      
      SpielVariablen.Allgemeines.IronmanName := NameExtern;
      
   end Ironman;
   
   
   
   procedure PlanetVernichtet
     (SpeziesExtern : in SpeziesDatentypen.Spezies_Enum)
   is begin
      
      SpielVariablen.Allgemeines.PlanetVernichtet := SpeziesExtern;
      
   end PlanetVernichtet;
   
      
   
   procedure Zusammenbruchszeit
     (ZeitExtern : in ZahlenDatentypen.EigenerInteger;
      RechnenSetzenExtern : in Boolean)
   is begin
      
      case
        RechnenSetzenExtern
      is
         when True =>
            SpielVariablen.Allgemeines.Zusammenbruchszeit := EigeneZahlPrüfen (AktuellerWertExtern => SpielVariablen.Allgemeines.Zusammenbruchszeit,
                                                                                ÄnderungExtern      => ZeitExtern);
            
         when False =>
            SpielVariablen.Allgemeines.Zusammenbruchszeit := ZeitExtern;
      end case;
      
   end Zusammenbruchszeit;
   
   
   
   procedure AnzahlEingesetzterPZB
   is begin
      
      SpielVariablen.Allgemeines.AnzahlEingesetzterPZB := EigeneZahlPrüfen (AktuellerWertExtern => SpielVariablen.Allgemeines.AnzahlEingesetzterPZB,
                                                                             ÄnderungExtern      => 1);
      
   end AnzahlEingesetzterPZB;
   
   
   
   procedure Standardeinstellungen
   is begin
      
      SpielVariablen.Allgemeines := WichtigesRecordKonstanten.LeerAllgemeines;
      
   end Standardeinstellungen;
   
   
   
   procedure GanzerEintrag
     (EintragExtern : in SpielRecords.AllgemeinesRecord)
   is begin
      
      SpielVariablen.Allgemeines := EintragExtern;
      
   end GanzerEintrag;

end SchreibeAllgemeines;

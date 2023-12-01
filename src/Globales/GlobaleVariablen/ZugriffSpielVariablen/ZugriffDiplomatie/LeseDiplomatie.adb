with SpielVariablen;

package body LeseDiplomatie is

   function AktuellerZustand
     (SpeziesEinsExtern : in SpeziesDatentypen.Spezies_Vorhanden_Enum;
      SpeziesZweiExtern : in SpeziesDatentypen.Spezies_Vorhanden_Enum)
      return DiplomatieDatentypen.Status_Untereinander_Enum
   is begin
      
      return SpielVariablen.Diplomatie (SpeziesEinsExtern, SpeziesZweiExtern).AktuellerZustand;
      
   end AktuellerZustand;
   
   
   
   function AktuelleSympathie
     (SpeziesEinsExtern : in SpeziesDatentypen.Spezies_Vorhanden_Enum;
      SpeziesZweiExtern : in SpeziesDatentypen.Spezies_Vorhanden_Enum)
      return DiplomatieDatentypen.Meinung
   is begin
      
      return SpielVariablen.Diplomatie (SpeziesEinsExtern, SpeziesZweiExtern).AktuelleSympathieBewertung;
      
   end AktuelleSympathie;
   
   
   
   function ZeitSeitÄnderung
     (SpeziesEinsExtern : in SpeziesDatentypen.Spezies_Vorhanden_Enum;
      SpeziesZweiExtern : in SpeziesDatentypen.Spezies_Vorhanden_Enum)
      return ZahlenDatentypen.EigenesNatural
   is begin
      
      return SpielVariablen.Diplomatie (SpeziesEinsExtern, SpeziesZweiExtern).ZeitSeitLetzterÄnderung;
      
   end ZeitSeitÄnderung;
   
   
   
   function GanzerEintrag
     (SpeziesEinsExtern : in SpeziesDatentypen.Spezies_Vorhanden_Enum;
      SpeziesZweiExtern : in SpeziesDatentypen.Spezies_Vorhanden_Enum)
      return SpielRecords.DiplomatieRecord
   is begin
      
      return SpielVariablen.Diplomatie (SpeziesEinsExtern, SpeziesZweiExtern);
      
   end GanzerEintrag;

end LeseDiplomatie;

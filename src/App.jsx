import React from 'react';
import { Routes, Route } from 'react-router-dom';
import { ThemeProvider, StyledEngineProvider } from '@mui/material/styles';
// questTheme
import AdvertisementPage from './components/AdvertisementPage/AdvertisementPage';
import questTheme from './MyDesignSystemDarkTheme';

function App() {
  return (
    <StyledEngineProvider injectFirst>
      <ThemeProvider theme={questTheme}>
        <Routes>
        <Route exact path="/" element={<AdvertisementPage/>} />
        </Routes>
      </ThemeProvider>
    </StyledEngineProvider>
  );
};

export default App;